import 'package:flutter/material.dart';

import '../models/api_functions.dart';
import '../widgets/home_page_widgets/pdf_loader.dart';

class HomeworkScreen extends StatefulWidget {
  const HomeworkScreen({super.key, required this.color});
  final Color color;

  @override
  State<HomeworkScreen> createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends State<HomeworkScreen> {
  var _isLoading = true;
  var homeworklist = [];
  @override
  void initState() {
    super.initState();
    _homework();
  }

  void _homework() async {
    var homework =
        await sendFetchReq(context, 'fetchHomeworkList', {'status': '1'});
    print(homework);
    if (homework != null) {
      if (mounted) {
        setState(() {
          homeworklist = homework;
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homework'),
        backgroundColor: widget.color,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: EdgeInsets.all(0),
              padding: const EdgeInsets.only(bottom: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: homeworklist.map((e) {
                    return Column(
                      children: [
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 18, bottom: 12),
                          child: Text(
                            e['homework_date'].toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontSize: 19,
                              //color: Colors.white
                            ),
                          ),
                        ),
                        Card(
                          shape: const ContinuousRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.zero),
                          ),
                          elevation: 4,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 32,
                              horizontal: 8,
                            ),
                            child: Column(
                              children: [
                                ...e['homework_list'].map((f) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 10, bottom: 5),
                                        padding: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                            border: BorderDirectional(
                                                // start: BorderSide(),
                                                // end: BorderSide(),
                                                bottom: BorderSide(width: 2))),
                                        child: Text(f['subject'],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontStyle: FontStyle.italic,
                                                fontSize: 19,
                                                color: Colors.black54)),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.only(
                                            bottom: 12, right: 12, left: 15),
                                        child: Text(
                                          f['homework_body'],
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ),
                                      Builder(builder: (context) {
                                        if (f['homework_doc']
                                            .toString()
                                            .isEmpty) {
                                          return const SizedBox();
                                        } else if (f['homework_doc']
                                                    .toString()
                                                    .split('.')
                                                    .last ==
                                                'png' ||
                                            f['homework_doc']
                                                    .toString()
                                                    .split('.')
                                                    .last ==
                                                'jpeg' ||
                                            f['homework_doc']
                                                    .toString()
                                                    .split('.')
                                                    .last ==
                                                'jpg' ||
                                            f['homework_doc']
                                                    .toString()
                                                    .split('.')
                                                    .last ==
                                                'webp') {
                                          return Image.network(f[
                                              'homework_doc']); //for image loading
                                        } else if (f['homework_doc']
                                                .toString()
                                                .split('.')
                                                .last ==
                                            'pdf') {
                                          return ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  // alignment: Alignment.center,
                                                  elevation: 5),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (ctx) =>
                                                            PdfLoaderWidget(
                                                              pdf: f['homework_doc']
                                                                  .toString(),
                                                              color:
                                                                  widget.color,
                                                            )));
                                              },
                                              child: const Text(
                                                  'Open Attachment')); //for pdf loading via button
                                        } else {
                                          return const SizedBox(); //for null case
                                        }
                                      }),
                                    ],
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
    );
  }
}
