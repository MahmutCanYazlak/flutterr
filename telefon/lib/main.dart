import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(CallApp());

class CallApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arama Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Arama Uygulaması'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final phoneController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    phoneController.dispose();
    super.dispose();
  }

  void _makeCall(String phoneNumber) async {
  final url = 'https://www.google.com/search?q=$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'Telefon numarasını buraya girin',
              ),
              keyboardType: TextInputType.phone,
              controller: phoneController,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _makeCall(phoneController.text),
              child: Text('Ara'),
            ),
          ],
        ),
      ),
    );
  }
}
