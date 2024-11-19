import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SyllabusWidget extends StatelessWidget {
  const SyllabusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child:
       SizedBox(child: 
       SfPdfViewer.network("https://www.clickdimensions.com/links/TestPDFfile.pdf"),)),
    );
  }
}
