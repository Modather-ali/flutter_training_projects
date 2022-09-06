import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import 'pdf_viewer.dart';

class SearchPDF extends StatefulWidget {
  const SearchPDF({super.key});

  @override
  State<SearchPDF> createState() => _SearchPDFState();
}

class _SearchPDFState extends State<SearchPDF> {
  List<FileSystemEntity> pdfFiles = [];

  getPDFFromStorage() async {
    Directory dir = Directory('/storage/emulated/0');
    await Permission.storage.request();
    var files = <FileSystemEntity>[];
    Completer<List<FileSystemEntity>> completer =
        Completer<List<FileSystemEntity>>();
    Stream<FileSystemEntity> lister = dir.list(recursive: false);
    if (files.length <= 10) {
      lister.listen((file) async {
        FileStat fileStat = file.statSync();

        if (fileStat.type == FileSystemEntityType.directory) {
          // await getPDFFromStorage();
        } else if (fileStat.type == FileSystemEntityType.file &&
            file.path.endsWith('.pdf')) {
          files.add(file);
        }
      }, onDone: () async {
        completer.complete(files);
        pdfFiles.addAll(await completer.future);
        setState(() {});
      });
    }
  }

  @override
  void initState() {
    getPDFFromStorage();
    super.initState();
  }
  // showPaths() async {
  //   Directory tempDir = await getTemporaryDirectory();
  //   String tempPath = tempDir.path;
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   String appDocPath = appDocDir.path;
  //   Directory? extDir = await getExternalStorageDirectory();

  //   log("Temporary Directory: $tempPath\nApplication Documents Directory: $appDocPath\nExternal Directory: $extDir");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // showPaths();
              getPDFFromStorage();
            },
            icon: const Icon(Icons.replay_circle_filled),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: pdfFiles != null ? pdfFiles.length : 1,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(
              Icons.picture_as_pdf,
              color: Colors.red,
            ),
            trailing: IconButton(
              onPressed: () {
                Share.shareFiles([pdfFiles[index].path],
                    subject: "Share pdf file",
                    text: "I am trying to share a pdf file");
              },
              icon: const Icon(
                Icons.share,
                color: Colors.blue,
              ),
            ),
            title: Text(pdfFiles != null ? pdfFiles[index].path : "Waiting..."),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PdfViewer(
                        pdfFile: pdfFiles[index].path,
                      )));
            },
          );
        },
      ),
    );
  }
}
