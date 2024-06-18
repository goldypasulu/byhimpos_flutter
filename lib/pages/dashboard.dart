import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:goldy_pos/components/flat_button.dart';
import 'package:goldy_pos/components/my_button.dart';
import 'package:goldy_pos/models/model_kategori.dart';
import 'package:goldy_pos/models/model_produk.dart';
import 'package:goldy_pos/pages/product_detail.dart';
import 'package:goldy_pos/services/api.dart';
import 'package:goldy_pos/services/env.dart';
import 'package:goldy_pos/services/general.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get_storage/get_storage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<ListProduct> list_product = [];
  List<ListKategori> list_kategori = [];
  bool loading = false;
  final TextEditingController _controller_seach = TextEditingController();
  var uid = '';
  var selected_id = '';
  String nama = '';
  String branch_id = '1';
  int is_selected = 1;
  void submit() {}
  void addIssue() {
    Navigator.pushNamed(context, '/add_issue');
  }

  List<Widget> widgets = [];

  @override
  void initState() {
    loadData();
    loadStorage(context);
  }

  loadStorage(BuildContext context) async {
    await GetStorage.init();
    final box = GetStorage();
    var userdata = box.read('userdata');

    setState(() {
      nama = userdata['name'];
      branch_id = userdata['branch_id'];
    });
  }

  void deleteData() async {
    Navigator.pop(context, '');
    setState(() {
      loading = true;
    });
    var body = jsonEncode(<String, String>{'id': selected_id.toString()});
    final response = await ApiServices().postData('/delete-issue', body);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      // loadData();
    } else {
      GenServices.alertError(
          context, 'Oops!', 'Newtwork error please try again');
    }
  }

  select_category() {
    return print('object');
  }

  void loadData() async {
    loadStorage(context);
    setState(() {
      is_selected = 0;
    });
    await GetStorage.init();
    final box = GetStorage();
    var udata = box.read('userdata');
    print(udata['id'].toString());
    var branchId = udata['branch_id'].toString();
    setState(() {
      loading = true;
    });
    final response = await http.get(
      Uri.parse('$apiUrl/get-product?branch_id=$branchId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      // body: jsonEncode(
      //     <String, String>{'employee_id': udata['id'].toString()})
    );
    if (response.statusCode == 200) {
      loadKategori();
      Map<String, dynamic> data = jsonDecode(response.body);
      String message = data["message"];
      var status = data["status"];
      var datas = data["data"];
      if (status == 'success') {
        Iterable it = datas;
        print('loada all data');
        setState(() {
          list_product = it.map((e) => ListProduct.fromJson(e)).toList();
        });
      } else {
        GenServices.alertError(context, 'Oops!', message);
      }
    } else {
      GenServices.alertError(
          context, 'Oops!', 'Newtwork error please try again');
    }
  }

  void loadKategori() async {
    loadStorage(context);
    await GetStorage.init();

    final response = await http.get(
      Uri.parse('$apiUrl/get-category'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });
      Map<String, dynamic> data = jsonDecode(response.body);
      String message = data["message"];
      var status = data["status"];
      var datas = data["data"];
      if (status == 'success') {
        Iterable it = datas;
        setState(() {
          list_kategori = it.map((e) => ListKategori.fromJson(e)).toList();
        });
      } else {
        GenServices.alertError(context, 'Oops!', message);
      }
    } else {
      GenServices.alertError(
          context, 'Oops!', 'Newtwork error please try again');
    }
  }

  void byCategory(id) async {
    loadStorage(context);
    await GetStorage.init();
    setState(() {
      loading = true;
      is_selected = id;
    });
    final response = await http.get(
      Uri.parse('$apiUrl/product-by-category?category_id=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      // body: jsonEncode(
      //     <String, String>{'employee_id': udata['id'].toString()})
    );
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });
      Map<String, dynamic> data = jsonDecode(response.body);
      String message = data["message"];
      var status = data["status"];
      var datas = data["data"];
      if (status == 'success') {
        Iterable it = datas;
        print('loada all data');
        setState(() {
          list_product = it.map((e) => ListProduct.fromJson(e)).toList();
        });
      } else {
        GenServices.alertError(context, 'Oops!', message);
      }
    } else {
      GenServices.alertError(
          context, 'Oops!', 'Newtwork error please try again');
    }
  }

  void searchProduk(val) async {
    loadStorage(context);
    await GetStorage.init();
    setState(() {
      loading = true;
    });
    final response = await http.post(Uri.parse('$apiUrl/search-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'name': val.toString()}));
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });
      Map<String, dynamic> data = jsonDecode(response.body);
      String message = data["message"];
      var status = data["status"];
      var datas = data["data"];
      if (status == 'success') {
        Iterable it = datas;
        print('loada all data');
        setState(() {
          list_product = it.map((e) => ListProduct.fromJson(e)).toList();
        });
      } else {
        GenServices.alertError(context, 'Oops!', message);
      }
    } else {
      GenServices.alertError(
          context, 'Oops!', 'Newtwork error please try again');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 255),
        useMaterial3: true,
        colorSchemeSeed: const Color.fromRGBO(31, 58, 116, 0.9),
      ),
      home: Scaffold(
        body: Container(
          color: const Color.fromRGBO(234, 245, 255, 0.9),
          child: Column(
            children: [
              headerColumn(),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ButtonKategori(
                      onPress: loadData,
                      label: 'All',
                      selected: is_selected == 0 ? 'true' : 'false',
                    ),
                    for (var itm in list_kategori)
                      ButtonKategori(
                          label: itm.name,
                          selected: is_selected == itm.id ? 'true' : 'false',
                          onPress: () {
                            byCategory(itm.id);
                          }),
                  ],
                ),
              ), // header

              Expanded(
                child: Container(
                  color: const Color.fromRGBO(234, 245, 255, 0.9),
                  height: 100,
                  child: ListView(children: [
                    loading
                        ? Container(
                            width: 40.0,
                            height: 50.0,
                            margin: const EdgeInsets.symmetric(vertical: 30),
                            child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.black,
                                ))),
                          )
                        : Container(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 1),
                            child: Center(
                              child: Container(
                                  padding: const EdgeInsets.all(0),
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: list_product.isNotEmpty
                                      ? Wrap(children: [
                                          for (var item in list_product)
                                            ProductCard(
                                                id: item.id,
                                                name: item.name,
                                                image: item.image,
                                                foto_path: foto_path_url,
                                                description: item.description,
                                                price: item.price)
                                        ])
                                      : Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: screenWidth / 2),
                                          child: const Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Center(
                                                  child: Column(
                                                children: [
                                                  Icon(
                                                    Icons.shopping_bag_outlined,
                                                    size: 50,
                                                    color: Colors.red,
                                                  ),
                                                  Text('Tidak ada data produk'),
                                                ],
                                              ))),
                                        )),
                            ),
                          ),
                    // ListData(),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column headerColumn() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 0),
          child: SizedBox(
            // height: 20,
            child: Text('Selamat Datang $nama'),
          ),
        ),
        const SizedBox(
          height: 30,
          child: Text(
            'Point Of Sales My-Him',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(31, 58, 116, 0.9)),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 200,
          height: 50,
          child: TextField(
            controller: _controller_seach,
            onChanged: (value) => searchProduk(value),
            readOnly: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Cari Produk Disini',
            ),
          ),
        )
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final dynamic id;
  final dynamic name;
  final dynamic image;
  final dynamic price;
  final dynamic foto_path;
  final dynamic description;

  const ProductCard(
      {super.key,
      required this.id,
      required this.name,
      required this.image,
      required this.foto_path,
      required this.description,
      required this.price});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailPage(
                    id: id,
                    name: name,
                    price: price,
                    description: description,
                    models: const ['Model D', 'Model E', 'Model F'],
                    foto_path:
                        image == null ? null : "$foto_path_url/$image")));
      },
      child: SizedBox(
        width: 100,
        child: Card(
          margin: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (image != null)
                Image.network(
                  "$foto_path/$image",
                  fit: BoxFit.cover,
                  height: 75,
                  width: 150,
                )
              else
                Image.asset(
                  'lib/images/no_image.png',
                  fit: BoxFit.cover,
                  height: 75,
                  width: 150,
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Text(
                    //   "IDR $price",
                    //   style: const TextStyle(fontSize: 15.0, color: Colors.red),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonKategori extends StatelessWidget {
  final Function()? onPress;
  final String? label;
  final String? selected;

  const ButtonKategori(
      {super.key,
      required this.onPress,
      required this.label,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    // The InkWell wraps the custom flat button widget.
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          width: 100,
          height: 40,
          decoration: BoxDecoration(
            color: selected == 'true' ? Colors.indigo : Colors.white,
            border: Border.all(
              color: Colors.orange, // Outline color
            ),
            borderRadius: BorderRadius.circular(
                8), // You can adjust the radius as per your preference
          ),
          child: Center(
            child: Text(
              label!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: selected == 'true' ? Colors.white : Colors.black,
                // Text color
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
