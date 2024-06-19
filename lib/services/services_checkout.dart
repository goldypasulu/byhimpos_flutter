import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:goldy_pos/services/env.dart';
import 'package:goldy_pos/services/general.dart';
import 'package:goldy_pos/models/model_cart_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> loadStorage(BuildContext context, Function setStateCallback) async {
  await GetStorage.init();
  final box = GetStorage();
  var userdata = box.read('userdata');

  setStateCallback(userdata['branch_id'], userdata['id']);
}

Future<void> loadingData(BuildContext context, Function setStateCallback, Function setLoadingCallback) async {
  setLoadingCallback(true);
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
    String message = data["message"];
    var status = data["status"];
    var datas = data["data"];

    if (status == 'success') {
      setLoadingCallback(false);
      Iterable it = datas;
      setStateCallback(it.map((e) => CartItem.fromJson(e)).toList());
    } else {
      GenServices.alertError(context, 'Oops!', message);
    }
  } else {
    GenServices.alertError(context, 'Oops!', 'Network error please try again');
  }
}

Future<void> loadCustomer(BuildContext context, TextEditingController hpController, Function(String, String) setStateCallback) async {
  final response = await http.post(
    Uri.parse('$apiUrl/search-customer'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'phone_number': hpController.text.toString(),
    }),
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    String message = data["message"];
    var status = data["status"];
    var datas = data["data"];

    if (status == 'success') {
      if (datas.length > 0) {
        setStateCallback(datas[0]['name'], datas[0]['phone_number']);
      } else {
        if (context.mounted) {
          GenServices.alertError(context, 'Not Found', 'Nomor Hp customer tidak ditemukan');
        }
      }
    } else {
      if (context.mounted) {
        GenServices.alertError(context, 'Oops!', message);
      }
    }
  } else {
    if (context.mounted) {
      GenServices.alertError(context, 'Oops!', 'Network error please try again');
    }
  }
}

Future<void> addCustomer(BuildContext context, String name, String phoneNumber, Function setStateCallback) async {
  final response = await http.post(
    Uri.parse('$apiUrl/add-customer'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'phone_number': phoneNumber,
    }),
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    String message = data["message"];
    var status = data["status"];

    if (status == 'success') {
      setStateCallback(name, phoneNumber);
      GenServices.alertError(context, 'Berhasil', 'Customer berhasil ditambahkan');
    } else {
      GenServices.alertError(context, 'Oops!', message);
    }
  } else {
    GenServices.alertError(context, 'Oops!', 'Network error please try again');
  }
}