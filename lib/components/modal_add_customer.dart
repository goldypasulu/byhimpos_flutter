import 'package:flutter/material.dart';
import 'package:goldy_pos/components/my_button_square.dart';


// MODAL ADD CUSTOMER =======
class ModalAddCustomer extends StatefulWidget {
  final TextEditingController hp_controller;
  final TextEditingController name_controller;
  const ModalAddCustomer(
      {super.key, required this.hp_controller, required this.name_controller});

  @override
  _ModalAddCustomerState createState() => _ModalAddCustomerState();
}

class _ModalAddCustomerState extends State<ModalAddCustomer> {
  @override
  void initState() {
    // TODO: implement initState
    widget.hp_controller.clear();
    widget.name_controller.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _back() {
      Navigator.of(context).pop();
    }

    return SizedBox(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'Daftarkan Customer',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                const Divider(),
                TextField(
                  controller: widget.name_controller,
                  readOnly: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nama Customer',
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: widget.hp_controller,
                  readOnly: false,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'No Hp',
                  ),
                ),
                Center(
                  child: Row(
                    children: [
                      MyButtonSquare(
                          onPress: () {
                            _back();
                          },
                          label: 'SUBMIT',
                          color: Colors.black,
                          color_border: Colors.white,
                          color_text: Colors.white),
                      MyButtonSquare(
                          onPress: () {
                            _back();
                          },
                          label: 'Batal',
                          color: Colors.grey,
                          color_border: Colors.white,
                          color_text: Colors.white),
                    ],
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

// MODAL INPUT CUSTOMER =======
class ModalCustomer extends StatefulWidget {
  final TextEditingController res_controller;
  const ModalCustomer({super.key, required this.res_controller});

  @override
  _ModalCustomerState createState() => _ModalCustomerState();
}

class _ModalCustomerState extends State<ModalCustomer> {
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
              const Text(
                'Input nomor HP Customer',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              const Divider(),
              TextField(
                controller: widget.res_controller,
                readOnly: false,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '08XXX',
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