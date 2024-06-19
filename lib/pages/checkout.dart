import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:goldy_pos/components/modal_add_customer.dart';
import 'package:goldy_pos/components/my_button.dart';
import 'package:goldy_pos/components/my_button_square.dart';
import 'package:goldy_pos/components/my_button_square_small.dart';
import 'package:goldy_pos/services/env.dart';
import 'package:goldy_pos/services/general.dart';
import 'package:goldy_pos/components/modal_bottom_sheets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:money_formatter/money_formatter.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  _CheckoutState createState() => _CheckoutState();
}

class CartItem {
  int id;
  String name;
  double price;
  String variant;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.variant,
  });

  double get total => price;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['harga_ml']),
      variant: json['variant'],
    );
  }
}

class _CheckoutState extends State<Checkout> {
  List<CartItem> cartItems = [];
  bool loading = false;
  bool is_tunai = true;
  bool is_non = false;
  bool show_kembalian = false;
  String branch_id = '';
  String customer_selected = '';
  String hp_selected = '';
  int user_id = 3;

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controllerHp = TextEditingController();
  final TextEditingController _controllerHpAdd = TextEditingController();
  final TextEditingController _controllerNameAdd = TextEditingController();
  @override
  void initState() {
    loadStorage(context);
    loadingData();
  }

  double get subtotal {
    return cartItems.fold(0.0, (total, current) => total + current.total);
  }

  double kembalian(String input) {
    if (input == null || input.isEmpty) {
      return 0.0; // or handle this scenario appropriately
    }

    // Clean and verify the input before parsing
    String cleanedInput = input.trim();
    if (!RegExp(r'^-?(([0-9]*)|(([0-9]+\.?[0-9]*)))$').hasMatch(cleanedInput)) {
      return 0.0; // or handle this scenario appropriately
    }

    try {
      double result = double.parse(cleanedInput);
      return result;
    } catch (e) {
      // Log the error or handle it visibly
      print('Error parsing double in kembalian: $e');
      return 0.0; // or handle this scenario appropriately
    }
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

  void loadingData() async {
    setState(() {
      loading = true;
    });
    await GetStorage.init();
    final box = GetStorage();
    var userdata = box.read('userdata');

    final response = await http.get(
      Uri.parse('$apiUrl/get-cart?user_id=${userdata['id'].toString()}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      String message = data["message"];
      var status = data["status"];
      var datas = data["data"];
      var jsonData = json.decode(response.body);
      if (status == 'success') {
        setState(() {
          loading = false;
          // cartItems = jsonData['data'];
        });
        Iterable it = datas;
        print('load all data');
        setState(() {
          cartItems = it.map((e) => CartItem.fromJson(e)).toList();
        });
      } else {
        GenServices.alertError(context, 'Oops!', message);
      }
    } else {
      GenServices.alertError(
          context, 'Oops!', 'Newtwork error please try again');
    }
  }

  void addCs() {}

  void gotoPos() {
    Navigator.pushReplacementNamed(context, '/tabs');
  }

  void removeItem(int index, id) {
    doDeleteCart(id);
    setState(() {
      cartItems.removeAt(index);
    });
  }

  void doUpdateCart(id, newQty) async {
    var cartId = id.toString();
    final response = await http.post(
      Uri.parse('$apiUrl/update-cart'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'cart_id': cartId, 'qty': newQty}),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String message = data["message"];
      var status = data["status"];
    } else {
      GenServices.alertError(
          context, 'Oops!', 'Newtwork error please try again');
    }
  }

  void doDeleteCart(id) async {
    var cartId = id.toString();
    final response = await http.get(
      Uri.parse('$apiUrl/delete-cart?id=$cartId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String message = data["message"];
      var status = data["status"];
    } else {
      GenServices.alertError(
          context, 'Oops!', 'Newtwork error please try again');
    }
  }

  void loadCustomer() async {
    final response = await http.post(
      Uri.parse('$apiUrl/search-customer'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phone_number': _controllerHp.text.toString(),
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String message = data["message"];
      var status = data["status"];
      var datas = data["data"];
      var jsonData = json.decode(response.body);
      if (status == 'success') {
        print(datas.length);
        if (datas.length > 0) {
          setState(() {
            customer_selected = datas[0]['name'];
            hp_selected = datas[0]['phone_number'];
          });
        } else {
          GenServices.alertError(
              context, 'Not Found', 'Nomor Hp customer tidak di temukan');
          // GenServices.alert(null, context, 'Tidak ditemukan',
          //     'Nomor Hp customer tidak di temukan, Anda ingin menambahkan nomor hp ini ?');
        }
      } else {
        GenServices.alertError(context, 'Oops!', message);
      }
    } else {
      GenServices.alertError(
          context, 'Oops!', 'Newtwork error please try again');
    }
  }

  void addCustomer() async {
    final response = await http.post(
      Uri.parse('$apiUrl/add-customer'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': _controllerNameAdd.text,
        'phone_number': _controllerHpAdd.text,
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String message = data["message"];
      var status = data["status"];
      var datas = data["data"];
      var jsonData = json.decode(response.body);
      if (status == 'success') {
        setState(() {
          customer_selected = _controllerNameAdd.text;
          hp_selected = _controllerHpAdd.text;
        });
        GenServices.alertError(
            context, 'Berhasil', 'Customer berhasil ditambahkan');
      } else {
        GenServices.alertError(context, 'Oops!', message);
      }
    } else {
      GenServices.alertError(
          context, 'Oops!', 'Newtwork error please try again');
    }
  }

  void goBayar() async {
    setState(() {
      loading = true;
    });

    final response = await http.post(
      Uri.parse('$apiUrl/checkout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phone_number': hp_selected,
        'name_customer': customer_selected,
        'user_id': user_id.toString(),
      }),
    );
        // Logging data sebelum dikirim
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String message = data["message"];
      var status = data["status"];
      var datas = data["data"];
      var jsonData = json.decode(response.body);
      if (status == 'success') {
        setState(() {
          loading = false;
        });
        GenServices.success(goBack, context, 'Berhasil', 'Transaksi berhasil');
      } else {
        GenServices.alertError(context, 'Oops!', message);
      }
    } else {
      GenServices.alertError(
          context, 'Oops!', 'Newtwork error please try again');
      debugPrint('error');
    }
  }

  void goBack() {
    Navigator.pop(context);
    Navigator.pop(context);
    dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // MoneyFormatter fmf = MoneyFormatter(amount: 12345678.9012345);
    MoneyFormatter fmf = MoneyFormatter(
      amount: 0,
      settings: MoneyFormatterSettings(
        symbol: 'IDR',
        thousandSeparator: '.',
        decimalSeparator: ',',
        symbolAndNumberSeparator: ' ',
        fractionDigits: 0,
      )
    );
    
      double parseDouble(String value) {
      try {
        return double.parse(value);
      } catch (e) {
        print('Error parsing double: $value');
        return 0.0; // or any default value you deem appropriate
      }
    }
    double calculatedAmount = kembalian((parseDouble(_controller.text)-subtotal).toString());
    print('calculatedAmount: $calculatedAmount');
    MoneyFormatterOutput fok = fmf.copyWith(amount: calculatedAmount).output;
    MoneyFormatterOutput fo = fmf.output;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaksi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  // width: 170,
                  height: 50,
                  child: Column(
                    children: [
                      const Text(
                        'Nama Customer :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        customer_selected == ''
                            ? '-- belum di set --'
                            : customer_selected,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ],
                  ),
                ),

                Column(
                  children: [
                    MyButtonSquareSmall(
                      color_border: Colors.black,
                      color_text: Colors.black,
                      onPress: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              ModalCustomer(res_controller: _controllerHp),
                        ).whenComplete(() {
                          loadCustomer();
                        });
                      },
                      label: 'Cari Customer',
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    MyButtonSquareSmall(
                      color_border: Colors.black,
                      color_text: Colors.white,
                      onPress: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => ModalAddCustomer(
                            hp_controller: _controllerHpAdd,
                            name_controller: _controllerNameAdd,
                          ),
                        ).whenComplete(() {
                          if (_controllerHpAdd.text != '' &&
                              _controllerNameAdd.text != '') {
                            addCustomer();
                          }
                        });
                      },
                      label: 'Add Customer',
                      color: Colors.green,
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: loading
                  ? Center(
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Center(
                                child: CircularProgressIndicator(
                              color: Colors.black,
                            ))),
                      ),
                    )
                  : Center(
                      child: cartItems.isNotEmpty
                          ? ListView.builder(
                              itemCount: cartItems.length,
                              itemBuilder: (context, index) {
                                final item = cartItems[index];
                                return ListTile(
                                  title: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item.name,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        'IDR ${item.total.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    iconSize: 20,
                                    color: Colors.red,
                                    icon: const Icon(Icons.delete),
                                    onPressed: () => removeItem(index, item.id),
                                  ),
                                );
                              },
                            )
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
                            ),
                    ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0),
                  child: Text(
                    'Subtotal',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: Text(
                    fmf.copyWith(amount: subtotal).output.symbolOnLeft,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    'Bayar',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: !loading
                      ? Text(
                          ': IDR ${_controller.text}',
                        )
                      : const Text('loading...'),
                ),
              ],
            ),
            show_kembalian
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          'Kembalian',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: !loading
                          ? Text(
                              fok.symbolOnLeft,
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          : const CircularProgressIndicator()  // Assuming 'loading' is a boolean controlling loading state.
                      ),
                    ],
                  )
                : const Row(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: MyButtonSquare(
                      onPress: () {
                        setState(() {
                          is_tunai = true;
                          is_non = false;
                        });
                      },
                      label: 'Tunai',
                      color: is_tunai ? Colors.green : Colors.white,
                      color_border: is_tunai ? Colors.green : Colors.white,
                      color_text: is_tunai ? Colors.white : Colors.black,
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: MyButtonSquare(
                      onPress: () {
                        setState(() {
                          is_tunai = false;
                          is_non = true;
                        });
                      },
                      label: 'Non Tunai',
                      color: is_non ? Colors.green : Colors.white,
                      color_border: is_non ? Colors.green : Colors.white,
                      color_text: is_non ? Colors.white : Colors.black,
                    )),
              ],
            ),
            // const Divider(),
            SizedBox(
              width: double.infinity,
              child: !show_kembalian
                  ? MyButtonSquare(
                      onPress: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              MyModalBottomSheet(resController: _controller),
                        ).whenComplete(() {
                          setState(() {
                            loading = true;
                          });
                          setState(() {
                            loading = false;
                            show_kembalian = true;
                          });
                        });
                      },
                      // onPress: () => GenServices.alert(
                      //     goBayar, context, 'Bayar Transaksi', 'Anda yakin  ?'),
                      label: 'BAYAR',
                      color: Colors.white,
                      color_border: Colors.black,
                      color_text: Colors.black)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyButtonSquare(
                            onPress: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => MyModalBottomSheet(
                                    resController: _controller),
                              ).whenComplete(() {
                                setState(() {
                                  loading = true;
                                });
                                setState(() {
                                  loading = false;
                                  show_kembalian = true;
                                });
                              });
                            },
                            label: 'UBAH NOMINAL BAYAR',
                            color: Colors.white,
                            color_border: Colors.black,
                            color_text: Colors.black),
                        MyButton(
                            onPress: () => {
                                  if (hp_selected == '')
                                    {
                                      GenServices.alertError(context, 'Ups',
                                          'Customer belum di pilih')
                                    }
                                  else
                                    {
                                      goBayar()
                                      // GenServices.alert(goBayar, context,
                                      //     'Bayar Transaksi', 'Anda yakin  ?')
                                    }
                                },
                            label: 'SUBMIT',
                            color: Colors.red),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
