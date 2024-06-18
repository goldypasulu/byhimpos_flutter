import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:goldy_pos/pages/dashboard.dart';
import 'package:goldy_pos/pages/history.dart';
import 'package:goldy_pos/pages/login.dart';
import 'package:goldy_pos/pages/profile.dart';
import 'package:goldy_pos/pages/tabs.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Set the status bar color and icon color
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Set your desired status bar color here
      statusBarIconBrightness:
          Brightness.dark, // Set the status bar icon color brightness
    ));

    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'By-Him',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 255, 255, 255)),
        ),
        home: const MyHomePage(),
        // ROUTERS
        routes: {
          '/loginpage': (context) => const Login(),
          '/welcome': (context) => const MyHomePage(),
          '/dashboard': (context) => const Dashboard(),
          '/tabs': (context) => const MyTabs(),
          '/history': (context) => const History(),
          '/profile': (context) => const Profile(),
        },
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  loadStorage(BuildContext context) async {
    await GetStorage.init();
    final box = GetStorage();
    var userdata = box.read('userdata');
    if (userdata != null) {
      Navigator.pushReplacementNamed(context, '/tabs');
    } else {
      Navigator.pushReplacementNamed(context, '/loginpage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'lib/images/logo_big.png',
            height: 200,
            width: 200,
          )),
          Container(
            margin: const EdgeInsets.only(top: 100),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
              onPressed: () {
                loadStorage(context);
              },
              child: const Text(
                'GET STARTED',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
