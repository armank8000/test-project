import 'package:dartx/dartx.dart';
import 'package:erp_student_app/models/Searchbox.dart';
import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../models/api_functions.dart';
import '../widgets/home_page_widgets/pdf_loader.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key});

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  TextEditingController textcontroller = TextEditingController();
  var _isLoading = true;
  var assignmentlist = [];
  Map<dynamic, List<dynamic>> groupedData = {};

  @override
  void initState() {
    _assignment();

    super.initState();
  }

  void _assignment() async {
    var assignment =
        await sendFetchReq(context, 'fetchAssignments', {'status': '1'});
    if (assignment != null) {
      print(assignment);
      if (mounted) {
        setState(() {
          assignmentlist = assignment;
          _isLoading = false;
        });
      }
    }
    setIntialValues();
  }

  setIntialValues() {
    if (mounted) {
      setState(() {
        groupedData =
            assignmentlist.groupBy((element) => element['subject_name']);
      });
    }
    print(groupedData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Assignment',
            style: TextStyle(color: Colors.white),
          ),
          actions: const [
            Icon(
              Icons.assignment,
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
            : Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Container(
                      //   margin: const EdgeInsets.all(8.0),
                      //   child: DropDownSearch(
                      //       title: "Search",
                      //       textController: textcontroller,
                      //       items:.toList()),
                      // ),
                      //   // child: TextField(
                      //   //   decoration: InputDecoration(
                      //   //     prefixIcon: Icon(Icons.search),
                      //   //     border: OutlineInputBorder(
                      //   //       borderRadius: BorderRadius.circular(50),
                      //   //     ),
                      //   //   ),
                      //   //   onChanged: (value) {
                      //   //     return null;
                      //   //   },
                      //   // ),
                      // ),
                      ...groupedData.keys.map((item) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                  left: 8, right: 8, top: 0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                item.toString(),
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: groupedData[item]!.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  child: ListTile(
                                    leading: Container(
                                      width: 40,
                                      height: 46,
                                      decoration: const BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 154, 0, 0)),
                                      child: const Icon(
                                        Icons.picture_as_pdf,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    title: Text(
                                      groupedData[item]![index]['heading'],
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    subtitle: const Text("Updated on"),
                                  ),
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) => PdfLoaderWidget(
                                              pdf: groupedData[item]![index]
                                                  ['assignment_file'],
                                              color: Colors.black))),
                                );
                              },
                            ),
                            const Divider(),
                            // ...groupedData[item]!.map(
                            //   (e) => Container(
                            //     child: InkWell(
                            //       child: ListTile(
                            //         leading: Icon(Icons.picture_as_pdf),
                            //         title: Text(e['heading']),
                            //       ),
                            //       onTap: () => Navigator.of(context).push(
                            //           MaterialPageRoute(
                            //               builder: (_) => PdfLoaderWidget(
                            //                   pdf: e['assignment_file'],
                            //                   color: Colors.black))),
                            //     ),
                            //   ),
                            // )
                          ],
                        );
                      })
                    ],
                  ),
                ))

        // : ListView(
        //     children: [
        //       ...groupedData.keys.map((item) {
        //         return ExpansionTile(
        //           title: Text(
        //             item,
        //             style: const TextStyle(
        //                 color: Colors.black,
        //                 fontWeight: FontWeight.w700,
        //                 fontStyle: FontStyle.italic),
        //           ),
        //           onExpansionChanged: (bool expanded) {
        //             setState(() {
        //               _customTileExpanded = expanded;
        //             });
        //           },
        //           trailing: Icon(
        //             _customTileExpanded
        //                 ? Icons.arrow_drop_down_circle
        //                 : Icons.arrow_drop_down,
        //           ),
        //           children: groupedData[item]!.map((e) {
        //             return ListTile(
        //               minTileHeight: 79,
        //               trailing: ElevatedButton(
        //                 style: ElevatedButton.styleFrom(
        //                     backgroundColor:
        //                         const Color.fromARGB(255, 210, 238, 244)),
        //                 child: const Text('Open'),
        //                 onPressed: () async {
        //                   Navigator.of(context).push(
        //                     MaterialPageRoute(
        //                       builder: (f) => PdfLoaderWidget(
        //                         pdf: e['assignment_file'],
        //                         color: Colors.black,
        //                       ),
        //                     ),
        //                   );
        //                 },
        //               ),
        //               title: Text(
        //                 e['heading'],
        //                 // style: const TextStyle(
        //                 //     color: Colors.black,
        //                 //     fontWeight: FontWeight.w700,
        //                 //     fontStyle: FontStyle.italic),
        //               ),
        //             );
        //           }).toList(),
        //         );
        //       })
        //     ],
        //   ),
        );
  }
}
