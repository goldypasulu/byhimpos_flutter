import 'package:flutter/material.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _selectedDevice;
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }

  _initBluetooth() async {
    bool isConnected = (await bluetooth.isConnected) ?? false;
    List<BluetoothDevice> devices = await bluetooth.getBondedDevices();

    setState(() {
      _isConnected = isConnected;
      _devices = devices;
    });
  }

  void _connect() {
    if (_selectedDevice != null) {
      bluetooth.connect(_selectedDevice!).catchError((error) {
        setState(() => _isConnected = false);
        print('Error: $error');
      });
      setState(() => _isConnected = true);
    }
  }

  void _disconnect() {
    bluetooth.disconnect();
    setState(() => _isConnected = false);
  }

  void _printTest() {
  if (_isConnected) {
    bluetooth.printNewLine();
    bluetooth.printCustom("Test Print", 1, 1);  // Use printCustom to print text
    bluetooth.printNewLine();
    bluetooth.printCustom("Connected to: ${_selectedDevice?.name}", 1, 1);  // Print the device name
    bluetooth.printNewLine();
    bluetooth.paperCut();  // Use paperCut if supported
  } else {
    _showSnackBar("Printer is not connected");
  }
}


  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color.fromRGBO(31, 58, 116, 0.9),
      ),
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(16.0),
        color: const Color.fromRGBO(234, 245, 255, 0.9), // Match theme
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Thermal Printer Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(31, 58, 116, 0.9),
              ),
            ),
            const SizedBox(height: 20),

            // Dropdown to select the printer
            Container(
              width: width / 1.3,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: DropdownButton<BluetoothDevice>(
                isExpanded: true,
                underline: const SizedBox(),
                hint: const Text('Select a printer'),
                value: _selectedDevice,
                items: _devices.map((device) {
                  return DropdownMenuItem(
                    value: device,
                    child: Text(device.name ?? 'Unknown'),
                  );
                }).toList(),
                onChanged: (device) {
                  setState(() {
                    _selectedDevice = device;
                  });
                },
              ),
            ),

            const SizedBox(height: 20),

            // Connect or Disconnect Button
            SizedBox(
              width: width / 1.3,
              child: ElevatedButton(
                onPressed: _isConnected ? _disconnect : _connect,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(31, 58, 116, 0.9),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    _isConnected ? 'Disconnect Printer' : 'Connect Printer',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Printer Connection Status
            Text(
              _isConnected ? 'Printer is connected' : 'Printer is not connected',
              style: TextStyle(
                fontSize: 16,
                color: _isConnected ? Colors.green : Colors.red,
              ),
            ),

            const SizedBox(height: 30),

            // Print Test Button
            SizedBox(
              width: width / 1.3,
              child: ElevatedButton(
                onPressed: _isConnected ? _printTest : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isConnected
                      ? const Color.fromRGBO(31, 58, 116, 0.9)
                      : Colors.grey,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    'Print Test',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
