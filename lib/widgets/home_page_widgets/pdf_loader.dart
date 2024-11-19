import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfLoaderWidget extends StatelessWidget {
  const PdfLoaderWidget({super.key, required this.pdf, required this.color});
 final String pdf;
final Color color;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: color,),
      body: SfPdfViewer.network(pdf,canShowSignaturePadDialog: false,enableTextSelection: false,canShowPageLoadingIndicator: true,enableDoubleTapZooming: true,
      ),
    );
  }
}