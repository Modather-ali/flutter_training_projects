import 'dart:io';

import 'package:bdf_office/screens/pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'screens/search_pdf.dart';
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
      home: const StartPage(),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
                onPressed: () async {
                  Directory tempDir = await getTemporaryDirectory();
                  String tempPath = tempDir.path;
                  File file = File("$tempPath/example.pdf");

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PdfViewer(
                            pdfFile: file.path,
                          )));
                },
                icon: const Icon(Icons.file_open),
                label: const Text("Open pdf")),
            SizedBox(
              height: 20,
              width: MediaQuery.of(context).size.width,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const WritePdf()));
              },
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text("New pdf"),
            ),
            SizedBox(
              height: 20,
              width: MediaQuery.of(context).size.width,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SearchPDF()));
              },
              icon: const Icon(Icons.search),
              label: const Text("Search pdf"),
            ),
          ],
        ),
      ),
    );
  }
}
