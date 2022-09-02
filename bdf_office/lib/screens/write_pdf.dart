import 'dart:developer';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'dart:io';

class WritePdf extends StatefulWidget {
  const WritePdf({super.key});

  @override
  State<WritePdf> createState() => _WritePdfState();
}

class _WritePdfState extends State<WritePdf> {
  final pdf = pw.Document();
  _writePdf() async {
    final file = File("example.pdf");

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello World"),
          );
        }));
    await file.writeAsBytes(await pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
            onPressed: () async {
              // _writePdf();
              Directory tempDir = await getTemporaryDirectory();
              String tempPath = tempDir.path;

              Directory appDocDir = await getApplicationDocumentsDirectory();
              String appDocPath = appDocDir.path;
              log("Temporary Directory: $tempPath\nApplication Documents Directory: $appDocPath");
            },
            icon: const Icon(Icons.save),
            label: const Text("Save bdf")),
      ),
    );
  }
}
