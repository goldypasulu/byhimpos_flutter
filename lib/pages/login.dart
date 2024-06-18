import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:goldy_pos/components/my_textfield.dart';
import 'package:goldy_pos/services/env.dart';
import 'package:goldy_pos/services/general.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  // text editing controller
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool user_valid = true;
  bool pass_valid = true;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    loadStorage(context);
  }

  loadStorage(BuildContext context) async {
    await GetStorage.init();
    final box = GetStorage();
    var userdata = box.read('userdata');
    if (userdata != null) {
      Navigator.pushReplacementNamed(context, '/tabs');
    }
  }

  saveStorage(v) async {
    await GetStorage.init();
    final data = GetStorage();
    data.write('userdata', v);
  }

  void _doLogin() async {
    if (usernameController.text == '' && passwordController.text == '') {
      return setState(() {
        pass_valid = false;
        user_valid = false;
      });
    }
    if (usernameController.text == '') {
      return setState(() {
        user_valid = false;
      });
    }
    if (passwordController.text == '') {
      return setState(() {
        pass_valid = false;
      });
    }

    setState(() {
      loading = true;
    });
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/login-user'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': usernameController.text,
          'password': passwordController.text
        }),
      );
      if (response.statusCode == 200) {
        setState(() {
          loading = false;
        });
        Map<String, dynamic> data = jsonDecode(response.body);
        String message = data["message"];
        var status = data["status"];
        var userdata = data["data"];
        if (status == 'success') {
          saveStorage(userdata);
          Navigator.pushReplacementNamed(context, '/tabs');
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
        // scaffoldBackgroundColor: const Color.fromRGBO(234, 245, 255, 0.9),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Container(
          // color: const Color.fromRGBO(234, 245, 255, 0.9),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: Column(
                    children: [
                      Center(
                          child: Image.asset(
                        'lib/images/logo_big.png',
                        height: 100,
                        width: 200,
                      )),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 35),

                  child: RichText(
                    text: const TextSpan(
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(31, 58, 116, 0.9)),
                        children: [
                          TextSpan(text: 'Selamat Datang di '),
                          TextSpan(
                              text: 'POS ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: 'By Him Perfume')
                        ]),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 30),
                // Text field username
                MyTextField(
                    contoller: usernameController,
                    placeholder: 'Email',
                    secretText: false,
                    height: 45,
                    valid: user_valid),
                const SizedBox(height: 15),
                // form password
                MyTextField(
                  contoller: passwordController,
                  placeholder: 'Password',
                  secretText: true,
                  valid: pass_valid,
                  height: 45,
                ),
                const SizedBox(height: 10),

                const SizedBox(height: 20),
                
                // button login
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => const Color.fromRGBO(31, 58, 116, 0.9)),
                      elevation: MaterialStateProperty.all(10),
                    ),
                    onPressed: () {
                      _doLogin();
                    },
                    child: Center(
                      child: loading
                          ? Container(
                              width: 40.0,
                              height: 40.0,
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ))),
                            )
                          : Container(
                              height: 40,
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: const Center(
                                  child: Text(
                                'Sign In',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
