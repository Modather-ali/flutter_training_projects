import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

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
                FileStat fileStat = pdfFiles[index].statSync();
                String createTime = fileStat.changed.toString().split(":")[0];
                String fileName = pdfFiles[index].path.split("/").last;
                String fileType = pdfFiles[index].path.split(".").last;
                num fileSize = File(pdfFiles[index].path).lengthSync() / 1024;
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text("File name:"),
                              subtitle: Text(fileName),
                            ),
                            ListTile(
                              title: const Text("Last changed:"),
                              subtitle: Text(createTime),
                            ),
                            ListTile(
                              title: const Text("Size:"),
                              subtitle: Text(
                                  "${fileSize.toString().split(".")[0]} KB"),
                            ),
                            ListTile(
                              title: const Text("Type"),
                              subtitle: Text(fileType),
                            ),
                            ListTile(
                              title: const Text("Path"),
                              subtitle: Text(pdfFiles[index].path),
                            ),
                          ],
                        ),
                      );
                    });
                // Share.shareFiles([pdfFiles[index].path],
                //     subject: "Share pdf file",
                //     text: "I am trying to share a pdf file");
              },
              icon: const Icon(
                Icons.info,
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
