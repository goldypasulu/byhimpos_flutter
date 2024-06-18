import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:goldy_pos/models/model_history.dart';
import 'package:goldy_pos/services/api.dart';
import 'package:goldy_pos/services/env.dart';
import 'package:goldy_pos/services/general.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<ListHistory> listHistory = [];
  bool loading = false;
  bool showSubmit = false;
  var uid = '';
  var selected_id = '';
  var date_selected;
  DateTime? _dateTime;
  DateTime? _dateTimeEnd;
  void submit() {}
  void addIssue() {
    Navigator.pushNamed(context, '/add_issue');
  }

  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadStorage(BuildContext context) async {
    await GetStorage.init();
  }

  void deleteData() async {
    Navigator.pop(context, '');
    setState(() {
      loading = true;
    });
    var body = jsonEncode(<String, String>{'id': selected_id.toString()});
    final response = await ApiServices().postData('/delete-issue', body);
    if (response.statusCode == 200) {
      jsonDecode(response.body);
      loadData();
    } else {
      GenServices.alertError(
          context, 'Oops!', 'Newtwork error please try again');
    }
  }

  void loadData() async {
    await GetStorage.init();
    final box = GetStorage();
    var udata = box.read('userdata');
    if (kDebugMode) {
      print(udata);
    }

    setState(() {
      loading = true;
    });
    final response = await http.get(
        Uri.parse(
            '$apiUrl/get-history-transactions?branch_id=${udata['branch_id']}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String message = data["message"];
      var status = data["status"];
      var datas = data["data"];
      if (status == 'success') {
        Iterable it = datas;
        setState(() {
          loading = false;
          listHistory = it.map((e) => ListHistory.fromJson(e)).toList();
        });
      } else {
        GenServices.alertError(context, 'Oops!', message);
      }
    } else {
      GenServices.alertError(
          context, 'Oops!', 'Newtwork error please try again');
    }
  }

  void submitSearch() async {
    await GetStorage.init();
    final box = GetStorage();
    var udata = box.read('userdata');

    setState(() {
      loading = true;
    });
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/get-history-transactions-by-date'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'start_date': _dateTime.toString().substring(0, 10),
          'end_date': _dateTimeEnd.toString().substring(0, 10),
          'branch_id': udata['branch_id'].toString()
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          loading = false;
        });
        Map<String, dynamic> data = jsonDecode(response.body);
        String message = data["message"];
        var datas = data["data"];
        var status = data["status"];
        if (status == 'success') {
          Iterable it = datas;
          setState(() {
            loading = false;
            listHistory = it.map((e) => ListHistory.fromJson(e)).toList();
          });
        } else {
          GenServices.alertError(context, 'Oops!', message);
        }
      } else {
        print(response.body);
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
              filterDate(),
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
                              for (var item in listHistory)
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
                                                  'No Transaksi',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                Text(
                                                  item.transaction_number
                                                      .toString(),
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
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
                                                  'Tanggal',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                Text(
                                                  item.transaction_date
                                                      .toString(),
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                )
                                              ]),
                                          const SizedBox(height: 10),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Nama Customer',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                Text(
                                                  item.name_customer.toString(),
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                )
                                              ]),
                                          const SizedBox(height: 10),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Total  ',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.red[300],
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  5))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                    child: Text(
                                                      NumberFormat.currency(
                                                              locale: 'id_ID',
                                                              symbol: 'Rp. ',
                                                              decimalDigits: 0)
                                                          .format(double.parse(
                                                              item.total_amount ??
                                                                  '0')),
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                )
                                              ]),
                                          const SizedBox(height: 10),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Discount ',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.orange[300],
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  5))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                    child: Text(
                                                      item.discount.toString(),
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                )
                                              ]),
                                          const SizedBox(height: 10),
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
            'History Transaksi',
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
                  TextSpan(text: 'List history '),
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
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Start Date',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                            _dateTime == null
                                ? 'Select start Date'
                                : _dateTime.toString().substring(0, 10),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _dateTime == null
                                    ? Colors.red
                                    : const Color.fromRGBO(31, 58, 116, 0.9))),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(31, 58, 116, 0.9),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0))),
                          child: IconButton(
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2099),
                                ).then((date) {
                                  //tambahkan setState dan panggil variabel _dateTime.
                                  setState(() {
                                    var output = date.toString();
                                    print(output.substring(0, 10));
                                    _dateTime = date;
                                    date_selected = _dateTime;
                                  });
                                });
                              },
                              icon: const Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                                size: 16,
                              )),
                        ),
                      ]),
                  const SizedBox(height: 5),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'End Date',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                            _dateTimeEnd == null
                                ? 'Select End Date'
                                : _dateTimeEnd.toString().substring(0, 10),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _dateTimeEnd == null
                                    ? Colors.red
                                    : const Color.fromRGBO(31, 58, 116, 0.9))),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(31, 58, 116, 0.9),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0))),
                          child: IconButton(
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2099),
                                ).then((date) {
                                  //tambahkan setState dan panggil variabel _dateTimeEnd.
                                  setState(() {
                                    var output = date.toString();
                                    print(output.substring(0, 10));
                                    _dateTimeEnd = date;
                                    date_selected = _dateTimeEnd;
                                    showSubmit = true;
                                  });
                                });
                              },
                              icon: const Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                                size: 16,
                              )),
                        ),
                      ]),
                  const SizedBox(height: 10),
                  showSubmit
                      ? InkWell(
                          onTap: () {
                            submitSearch();
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                              child: Text(
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ))
      ],
    );
  }
}
