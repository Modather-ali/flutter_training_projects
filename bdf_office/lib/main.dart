import 'package:bdf_office/screens/pdf_viewer.dart';
import 'package:flutter/material.dart';

import 'screens/write_pdf.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WritePdf(),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => PdfViewer()));
            },
            icon: const Icon(Icons.file_open),
            label: const Text("Open bdf")),
      ),
    );
  }
}
