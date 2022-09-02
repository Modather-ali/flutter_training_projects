import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatelessWidget {
  PdfViewer({super.key});
  final PdfViewerController _pdfViewerController = PdfViewerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter PdfViewer'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_up,
                color: Colors.white,
              ),
              onPressed: () {
                _pdfViewerController.searchText("Program");
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
              onPressed: () {
                _pdfViewerController.zoomLevel = 2;
              },
            )
          ],
        ),
        body: SfPdfViewer.asset(
          "assets/bdfs/coders-at-work.pdf",
          controller: _pdfViewerController,
        ));
  }
}
