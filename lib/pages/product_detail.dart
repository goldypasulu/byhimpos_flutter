import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:goldy_pos/components/my_button_square.dart';
import 'package:goldy_pos/pages/checkout.dart';
import 'package:goldy_pos/services/env.dart';
import 'package:goldy_pos/services/general.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class ProductDetailPage extends StatefulWidget {
  final dynamic id;
  final dynamic name;
  final dynamic models;
  final dynamic price;
  final dynamic foto_path;
  final dynamic description;

  const ProductDetailPage(
      {super.key,
      required this.id,
      required this.name,
      required this.models,
      required this.foto_path,
      required this.description,
      required this.price});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;
  List<dynamic> bottles = [];
  String? selectedVariant;
  String? selectedBottleSize;
  String? hargaMl = 0.toString();
  String? bottleId;
  List<String> variants = [];
  List<String> bottleSizes = [];

  String branch_id = '';
  int user_id = 1;
  var selectedModel;
  var selectedVarian;
  var showBtn = false;
  bool loading = false;
  final quantityController = TextEditingController();
  String calculatedPrice = '';

  @override
  void initState() {
    super.initState();
    loadBottles();
    loadStorage(context);
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

  void updateBottleSizes(String? variant) {
    setState(() {
      selectedBottleSize = null;
      hargaMl = null;
      bottleId = null;
      bottleSizes = bottles
          .where((item) => item['variant'] == variant)
          .map<String>((item) => item['bottle_size'].toString())
          .toList();
      showBtn = false;
    });
  }

  void updateHargaMl(String? variant, String? bottleSize) {
    if (variant != null && bottleSize != null) {
      final item = bottles.firstWhere(
          (element) =>
              element['variant'] == variant &&
              element['bottle_size'].toString() == bottleSize,
          orElse: () => null);
      if (item != null) {
        print('Found item: $item'); // Debug print
        setState(() {
          hargaMl = NumberFormat('#,###').format(int.parse(item['harga_ml']));
          selectedModel = bottleSize;
          selectedVarian = variant;
          bottleId = item['id'].toString(); // Store bottle_id
          showBtn = true; 
        });
      } else {
        print(
            'Item not found for variant $variant and bottle size $bottleSize'); // Debug print
        setState(() {
          hargaMl = 0.toString();
          bottleId = null;
          showBtn = false;
        });
      }
    } else {
      setState(() {
        hargaMl = 0.toString();
        bottleId = null;
        showBtn = false; 
      });
    }
  }

  void goCheckout() async {
    setState(() {
      loading = true;
    });

    final response = await http.post(
      Uri.parse('$apiUrl/add-to-cart'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'product_id': widget.id.toString(),
        'branch_id': branch_id,
        'user_id': user_id.toString(),
        'bottle_id': bottleId,
        'bottle_size': selectedModel,
        'variant': selectedVarian,
      }),
    );

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
      appBar: AppBar(title: const Text('Product Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: widget.foto_path != null
                    ? Image.network(
                        widget.foto_path,
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      )
                    : Image.asset('lib/images/no_image.png',
                        fit: BoxFit.cover, height: 200, width: double.infinity),
              ),
              const SizedBox(height: 16.0),
              Text(
                widget.name,
                style: const TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                'IDR $hargaMl',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.green[700],
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(widget.description),
              const SizedBox(height: 16.0),
              Wrap(
                spacing: 16.0,
                children: <Widget>[
                  DropdownButton<String>(
                    hint: const Text('Select Variant'),
                    value: selectedVariant,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedVariant = newValue;
                        updateBottleSizes(newValue);
                        updateHargaMl(newValue, selectedBottleSize);
                      });
                    },
                    items:
                        variants.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  DropdownButton<String>(
                    hint: const Text('Select Bottle Size'),
                    value: selectedBottleSize,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedBottleSize = newValue;
                        updateHargaMl(selectedVariant, newValue);
                      });
                    },
                    items: bottleSizes
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              showBtn
                  ? Center(
                      child: MyButtonSquare(
                          color: Colors.green,
                          color_border: Colors.green,
                          color_text: Colors.white,
                          label: loading ? 'LOADING...' : 'LANJUT PEMBAYARAN',
                          onPress: () {
                            goCheckout();
                          }),
                    )
                  : const Center(),
            ],
          ),
        ),
      ),
    );
  }
}
