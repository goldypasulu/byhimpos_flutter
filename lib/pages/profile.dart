import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
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
          body: Container(
            child: Stack(
              children: <Widget>[
                Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Container(
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: height / 15, left: height / 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                // height: 70,
                                width: 200,
                                // child: Image.asset(
                                //   'lib/images/logo_1.png',
                                //   fit: BoxFit.cover,
                                // ),
                              ),
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
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: width / 4,
                              left: width / 20,
                              right: width / 20),
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black45,
                                          blurRadius: 2.0,
                                          offset: Offset(0.0, 2.0))
                                    ]),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: width / 20),
                                child: Column(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 15),
                                        const Text(
                                          'Brach Id',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          height: 30,
                                          width: width / 1.3,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Text(
                                              branch_id,
                                              style: TextStyle(
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        const Text(
                                          'Role',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          height: 30,
                                          width: width / 1.3,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Text(
                                              role,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        const Text(
                                          'Name',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          height: 30,
                                          width: width / 1.3,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Text(
                                              nama,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        const Text(
                                          'Email',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          height: 30,
                                          width: width / 1.3,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Text(
                                              email,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        const Text(
                                          'Username',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          height: 30,
                                          width: width / 1.3,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Text(
                                              username,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: height / 40),
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) =>
                                                        const Color.fromRGBO(
                                                            31, 58, 116, 0.9)),
                                            elevation:
                                                MaterialStateProperty.all(10),
                                          ),
                                          onPressed: () => GenServices.alert(
                                              onLogout,
                                              context,
                                              'Logout',
                                              'Are you sure ?'),
                                          child: Center(
                                            child: Container(
                                              height: 40,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: const Center(
                                                  child: Text(
                                                'Logout',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              )),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget headerChild(String header, String value) => Expanded(
          child: Column(
        children: <Widget>[
          Text(header),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            value,
            style: const TextStyle(
                fontSize: 14.0,
                color: Color.fromARGB(255, 34, 136, 225),
                fontWeight: FontWeight.bold),
          )
        ],
      ));

  Widget infoChild(double width, IconData icon, data) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: InkWell(
          child: Row(
            children: <Widget>[
              SizedBox(
                width: width / 10,
              ),
              Icon(
                icon,
                color: const Color.fromARGB(255, 34, 136, 225),
                size: 36.0,
              ),
              SizedBox(
                width: width / 20,
              ),
              Text(data)
            ],
          ),
          onTap: () {
            print('Info Object selected');
          },
        ),
      );
}
