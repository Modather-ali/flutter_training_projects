import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class BdfView extends StatelessWidget {
  const BdfView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfPdfViewer.asset(
      "assets/bdfs/coders-at-work.pdf",
    ));
  }
}
