import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:goldy_pos/components/my_button_square.dart';
import 'package:goldy_pos/components/my_button_square_small.dart';
import 'package:goldy_pos/models/model_produk_stock.dart';
import 'package:goldy_pos/services/api.dart';
import 'package:goldy_pos/services/env.dart';
import 'package:goldy_pos/services/general.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StokOpname extends StatefulWidget {
  const StokOpname({super.key});

  @override
  State<StokOpname> createState() => _StokOpnameState();
}

class _StokOpnameState extends State<StokOpname> {
  List<ListProductStock> listProductStock = [];
  final TextEditingController _controller = TextEditingController();
  bool loading = false;
  bool showSubmit = false;
  var uid = '';
  var selected_id = '';
  var product_selected = '';
  var id_product_selected = '';
  var date_selected;

  void submit() {}
  void addIssue() {
    Navigator.pushNamed(context, '/add_issue');
  }

  List<Widget> widgets = [];

  @override
  void initState() {
    loadData();
  }

  loadStorage(BuildContext context) async {
    await GetStorage.init();
    final box = GetStorage();
    var userdata = box.read('userdata');
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
      loadData();
    } else {
      GenServices.alertError(
          context, 'Oops!', 'Newtwork error please try again');
    }
  }

  void loadData() async {

    await GetStorage.init();
    final box = GetStorage();
    var userdata = box.read('userdata');

    setState(() {
      loading = true;
    });
    final response = await http.get(
      Uri.parse('$apiUrl/get-current-stock-by-branch?branch_id=${userdata['branch_id']}'), 
        headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
        },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String message = data["message"];
      var status = data["status"];
      var datas = data["data"];
      if (status == 'success') {
        Iterable it = datas;
        setState(() {
          loading = false;
          listProductStock =
              it.map((e) => ListProductStock.fromJson(e)).toList();
        });
      print(response.body);
      } else {
        GenServices.alertError(context, 'Oops!', message);
      }
    } else {
      GenServices.alertError(
          context, 'Oops!', 'Newtwork error please try again');
    }
  }

  void addStock() async {
    await GetStorage.init();
    final box = GetStorage();
    var udata = box.read('userdata');

    setState(() {
      loading = true;
    });
    try {
      final response = await http.post(
        //Uri.parse('$apiUrl/add-stock-opname'),
        Uri.parse('$apiUrl/restock'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'product_id': id_product_selected,
          'total_weight': _controller.text
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        setState(() {
          loading = false;
        });
        Map<String, dynamic> data = jsonDecode(response.body);
        String message = data["message"];
        var status = data["status"];
        if (status == 200) {
          loadData();
        } else {
          GenServices.alertError(context, 'Oops!', message);
        }
      } else {
        GenServices.alertError(
            context, 'Oops!', 'Newtwork error please try again');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(234, 245, 255, 0.9),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(234, 245, 255, 0.9),
        ),
        body: Container(
          color: const Color.fromRGBO(234, 245, 255, 0.9),
          child: Column(
            children: [
              // header
              headerColumn(),
              Expanded(
                child: SizedBox(
                  height: 300,
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
                        : Column(
                            children: [
                              for (var item in listProductStock)
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.9),
                                          spreadRadius: 5,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Nama Produk',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                Text(
                                                  item.name.toString(),
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                )
                                              ]),
                                          const SizedBox(height: 5),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Current Stock (ml)',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                Text(
                                                  '${item.current_stock} ',
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                )
                                              ]),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          MyButtonSquareSmall(
                                            color_border: Colors.black,
                                            color_text: Colors.white,
                                            onPress: () {
                                              setState(() {
                                                product_selected = item.name;
                                                id_product_selected =
                                                    item.product_id;
                                              });
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) =>
                                                    ModalAddStock(
                                                  product_selected:
                                                      product_selected,
                                                  stock_controller: _controller,
                                                ),
                                              ).whenComplete(() {
                                                if (_controller.text != '') {
                                                  addStock();
                                                }
                                              });
                                            },
                                            label: 'Add Stock',
                                            color: Colors.green,
                                          )
                                        ],
                                      ),
                                    )),
                            ],
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 40,
          child: Text(
            'RESTOCK PRODUCT',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(31, 58, 116, 0.9)),
          ),
        ),
        SizedBox(
          height: 20,
          child: RichText(
            text: const TextSpan(
                style: TextStyle(fontSize: 14, color: Colors.black),
                children: [
                  TextSpan(text: 'List current stock '),
                ]),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }

  Column filterDate() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.9),
                  spreadRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [],
              ),
            ))
      ],
    );
  }
}

// MODAL INPUT CUSTOMER =======
class ModalAddStock extends StatefulWidget {
  final TextEditingController stock_controller;
  final String product_selected;
  const ModalAddStock(
      {super.key,
      required this.stock_controller,
      required this.product_selected});

  @override
  _ModalAddStockState createState() => _ModalAddStockState();
}

class _ModalAddStockState extends State<ModalAddStock> {
  @override
  void initState() {
    // TODO: implement initState
    widget.stock_controller.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _back() {
      Navigator.of(context).pop();
    }

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                widget.product_selected,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              const Divider(),
              TextField(
                controller: widget.stock_controller,
                readOnly: false,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'New Stock',
                ),
              ),
              Center(
                child: MyButtonSquare(
                    onPress: () {
                      _back();
                    },
                    label: 'SUBMIT',
                    color: Colors.black,
                    color_border: Colors.white,
                    color_text: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
