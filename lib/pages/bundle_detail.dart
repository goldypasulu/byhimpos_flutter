import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:goldy_pos/components/my_button_square.dart';
import 'package:goldy_pos/pages/checkout.dart';
import 'package:goldy_pos/services/env.dart';
import 'package:goldy_pos/services/general.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:goldy_pos/models/model_produk.dart'; // Assuming you have this import for the models

class BundleDetailPage extends StatefulWidget {
  final Bundle bundle;

  const BundleDetailPage({super.key, required this.bundle});

  @override
  _BundleDetailPageState createState() => _BundleDetailPageState();
}

class _BundleDetailPageState extends State<BundleDetailPage> {
  bool loading = false;
  List<String> variants = [];
  List<dynamic> bottles = [];
  String branch_id = '';
  int user_id = 1;

  @override
  void initState() {
    super.initState();
    loadBottles();
    loadStorage(context);
    // Any additional initialization if needed
  }

    loadStorage(BuildContext context) async {
    await GetStorage.init();
    final box = GetStorage();
    var userdata = box.read('userdata');

    setState(() {
      branch_id = userdata['branch_id'];
      user_id = userdata['id'];
    });
  }

  void loadBottles() async {
    final response = await http.get(
      Uri.parse('$apiUrl/get-bottle'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String message = data["message"];
      var status = data["status"];
      var jsonData = json.decode(response.body);
      if (status == 'success') {
        setState(() {
          bottles = jsonData['data'];
          variants = bottles
              .map((item) => item['variant'] as String?)
              .where((variant) => variant != null)
              .cast<String>()
              .toSet()
              .toList();
          variants.removeWhere((variant) => variant == null);
        });
      } else {
        GenServices.alertError(context, 'Oops!', message);
      }
    } else {
      GenServices.alertError(
          context, 'Oops!', 'Network error please try again');
    }
  }

  void goCheckout() async {
    setState(() {
      loading = true;
    });

    // Prepare the data for the API request
    final List<Map<String, dynamic>> bundleItems = widget.bundle.products.map((product) {
      return {
        'product_id': product.productId.toString(),
        'bottle_id': product.bottleId.toString(), // Ensure this is set correctly
        'quantity': product.bundleQuantity.toString(),
        'discount': product.bundleDiscount.toString(),
      };
    }).toList();

    final requestData = {
      'bundle_id': widget.bundle.id.toString(),
      'branch_id': branch_id, // Replace with the actual branch_id if available
      'user_id': user_id,   // Replace with the actual user_id from storage
      'items': bundleItems,
    };

    // Logging untuk data yang dikirim
    print('Request Data: $requestData');

    final response = await http.post(
      Uri.parse('$apiUrl/bundle-to-cart'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestData),
    );

    // Logging untuk respons dari API
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String message = data["message"];
      var status = data["status"];
      json.decode(response.body);
      if (status == 'success') {
        setState(() {
          loading = false;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Checkout()));
      } else {
        GenServices.alertError(context, 'Oops!', message);
      }
    } else {
      GenServices.alertError(
          context, 'Oops!', 'Network error please try again');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bundle Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: widget.bundle.products.isNotEmpty && widget.bundle.products.first.productImage != null
                    ? Image.network(
                        widget.bundle.products.first.productImage!,
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      )
                    : Image.asset('lib/images/no_image.png',
                        fit: BoxFit.cover, height: 200, width: double.infinity),
              ),
              const SizedBox(height: 16.0),
              Text(
                widget.bundle.name,
                style: const TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                'IDR ${NumberFormat('#,###').format(widget.bundle.price)}',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.green[700],
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(widget.bundle.description),
              const SizedBox(height: 16.0),
              const Text(
                'Products in this bundle:',
                style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Column(
                children: widget.bundle.products.map((product) {
                  return ListTile(
                    title: Text(product.productName ?? ''),
                    subtitle: Text(product.productDescription ?? ''),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: MyButtonSquare(
                    color: Colors.green,
                    color_border: Colors.green,
                    color_text: Colors.white,
                    label: loading ? 'LOADING...' : 'LANJUT PEMBAYARAN',
                    onPress: () {
                      goCheckout();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
