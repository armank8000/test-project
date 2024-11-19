import 'package:dartx/dartx.dart';
import 'package:erp_student_app/screens/syllabus_detail_screen.dart';
import 'package:flutter/material.dart';

import '../models/api_functions.dart';

class SyllabusScreen extends StatefulWidget {
  const SyllabusScreen({super.key});

  @override
  State<SyllabusScreen> createState() => _SyllabusScreenState();
}

class _SyllabusScreenState extends State<SyllabusScreen> {
  // bool _customTileExpanded = false;
  var _isLoading = true;
  var syllabuslist = [];
  Map<dynamic, List<dynamic>> groupedData = {};

  @override
  void initState() {
    _syllabus();
    super.initState();
  }

  setIntialValues() {
    if (mounted) {
      setState(() {
        groupedData =
            syllabuslist.groupBy((element) => element['subject_name']);
      });
    }
    print(groupedData);
  }

  void _syllabus() async {
    var syllabus =
        await sendFetchReq(context, 'fetchSyllabus', {'status': '1'});
    if (syllabus != null) {
      if (mounted) {
        setState(() {
          syllabuslist = syllabus;
          _isLoading = false;
        });
      }
    }
    setIntialValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Syllabus',
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          Icon(
            Icons.library_books,
            size: 28.0,
            color: Colors.white,
          ),
          SizedBox(width: 8.0),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView(
              padding: EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              children: [
                ...groupedData.keys.map((item) {
                  return InkWell(
                    child: Card(
                      elevation: 5,
                      child: Stack(children: [
                        Image.asset('lib/assets/unnamed.jpg'),
                        Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            item.toString(),
                            style: const TextStyle(
                                fontSize: 23,
                                backgroundColor: Colors.transparent),
                          ),
                        ),
                      ]),

                      // children: groupedData[item]!.map((e) {
                      //   return ListTile(
                      //     trailing: ElevatedButton(
                      //       style: ElevatedButton.styleFrom(
                      //           backgroundColor:
                      //               Color.fromARGB(255, 210, 238, 244)),
                      //       child: Text('Open'),
                      //       onPressed: () async {
                      //         Navigator.of(context).push(
                      //           MaterialPageRoute(
                      //             builder: (f) => PdfLoaderWidget(
                      //               pdf: e['syllabus_file'],
                      //               color: Colors.black,
                      //             ),
                      //           ),
                      //         );
                      //       },
                      //     ),
                      //     title: Text(
                      //       e['heading'],
                      //       // style: const TextStyle(
                      //       //     color: Colors.black,
                      //       //     fontWeight: FontWeight.w700,
                      //       //     fontStyle: FontStyle.italic),
                      //     ),
                      //   );
                      // }).toList(),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (l) => SyllabusDetailScreen(
                                data: groupedData[item]!,
                                tittle: item.toString(),
                              )));
                    },
                  );
                })
              ],
            ),
    );
  }
}
