import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:goldy_pos/pages/settings_page.dart';
import 'package:goldy_pos/services/general.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var nama = '';
  var role = '';
  var email = '';
  var branch_id = '';
  var username = '';

  void onLogout() async {
    print('logout');
    await GetStorage.init();
    final box = GetStorage();
    box.erase();
    Navigator.pushReplacementNamed(context, '/loginpage');
  }

  void onSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    ); // Navigate to settings page
  }

  @override
  void initState() {
    super.initState();
    loadStorage(context);
  }

  loadStorage(BuildContext context) async {
    await GetStorage.init();
    final box = GetStorage();
    var userdata = box.read('userdata');

    setState(() {
      nama = userdata['name'];
      email = userdata['email'];
      branch_id = userdata['branch_id'];
      role = userdata['role'];
      username = userdata['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(234, 245, 255, 0.9),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(234, 245, 255, 0.9),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'Profile',
                          style: TextStyle(
                              fontSize: 25.0,
                              color: Color.fromRGBO(31, 58, 116, 0.9),
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'See Your Profile here',
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Color.fromRGBO(31, 58, 116, 0.9),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        _buildProfileField('Brach Id', branch_id, width),
                        const SizedBox(height: 15),
                        _buildProfileField('Role', role, width),
                        const SizedBox(height: 15),
                        _buildProfileField('Name', nama, width),
                        const SizedBox(height: 15),
                        _buildProfileField('Email', email, width),
                        const SizedBox(height: 15),
                        _buildProfileField('Username', username, width),
                        const SizedBox(height: 30),
                        _buildButton('Settings', () {
                          onSettings();
                        }),
                        const SizedBox(height: 10),
                        _buildButton('Logout', () {
                          GenServices.alert(
                              onLogout, context, 'Logout', 'Are you sure ?');
                        }),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ), 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, String value, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.black)),
        const SizedBox(height: 5),
        Container(
          height: 30,
          width: width / 1.3,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              value,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(31, 58, 116, 0.9),
          elevation: 10,
        ),
        onPressed: onPressed,
        child: Center(
          child: Container(
            height: 40,
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Center(
              child: Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
