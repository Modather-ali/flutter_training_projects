import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class SearchPDF extends StatefulWidget {
  const SearchPDF({super.key});

  @override
  State<SearchPDF> createState() => _SearchPDFState();
}

class _SearchPDFState extends State<SearchPDF> {
  List<FileSystemEntity>? pdfFiles;
  Future<List<FileSystemEntity>> getPDFFromStorage(Directory dir) async {
    await Permission.storage.request();
    var files = <FileSystemEntity>[];
    var completer = Completer<List<FileSystemEntity>>();
    var lister = dir.list(recursive: false);
    if (files.length <= 10) {
      lister.listen((file) async {
        FileStat fileStat = file.statSync();

        if (fileStat.type == FileSystemEntityType.directory) {
          await getPDFFromStorage(Directory(file.uri.toFilePath()));
        } else if (fileStat.type == FileSystemEntityType.file &&
            file.path.endsWith('.pdf')) {
          files.add(file);
        }
      }, onDone: () async {
        completer.complete(files);
        pdfFiles = await completer.future;
        setState(() {
          print(pdfFiles);
        });
      });
    }
    return completer.future;
  }

  Directory dir = Directory('/storage/emulated/0');

  showPaths() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    Directory? extDir = await getExternalStorageDirectory();

    log("Temporary Directory: $tempPath\nApplication Documents Directory: $appDocPath\nExternal Directory: $extDir");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // showPaths();
              getPDFFromStorage(dir);
            },
            icon: const Icon(Icons.replay_circle_filled),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: pdfFiles != null ? pdfFiles!.length : 1,
        itemBuilder: (context, index) {
          return Text(pdfFiles != null ? pdfFiles![index].path : "Waiting...");
        },
      ),
    );
  }
}
