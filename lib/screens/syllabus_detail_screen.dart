import 'package:flutter/material.dart';

import '../widgets/home_page_widgets/pdf_loader.dart';

class SyllabusDetailScreen extends StatefulWidget {
  const SyllabusDetailScreen(
      {super.key, required this.data, required this.tittle});
  final List data;
  final String tittle;

  @override
  State<SyllabusDetailScreen> createState() => _SyllabusDetailScreenState();
}

class _SyllabusDetailScreenState extends State<SyllabusDetailScreen> {
  // bool _customTileExpanded = false;
  // var _isLoading = false;
  // var assignmentlist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tittle),
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          ...widget.data.map((item) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (m) => PdfLoaderWidget(
                          pdf: item['syllabus_file'], color: Colors.black)));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.picture_as_pdf,
                    color: const Color.fromARGB(255, 138, 14, 5),
                    size: 48,
                  ),
                  dense: false,
                  shape: Border.all(
                      width: 1.5, color: Color.fromARGB(200, 200, 200, 200)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                  textColor: Colors.black,
                  tileColor: Colors.white,
                  title: Text(
                    item['heading'],
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.open_in_new,
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
