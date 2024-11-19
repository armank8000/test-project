import 'package:erp_student_app/models/api_functions.dart';
import 'package:erp_student_app/models/functions.dart';
import 'package:flutter/material.dart';

import 'update_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  dynamic studentDetail = [];
  var _isLoading = true;
  String image = '';
  List<Map<String, dynamic>> details = [];

  @override
  void initState() {
    super.initState();
    _fetchDetail();
  }

  studentListForWidget(studentDetail) {
    if (mounted) {
      setState(() {
        details = [
          // {'key': 'Name', 'value': studentDetail['name']},
          {'key': 'UDISE Code', 'value': studentDetail['udise_code']},
          {'key': 'Gender', 'value': studentDetail['gender']},
          // {'key': 'Class', 'value': studentDetail['class']},
          // {'key': 'Section', 'value': studentDetail['section']},
          // {'key': 'Enrollment No.', 'value': studentDetail['enrolment']},
          {'key': 'Blood Group', 'value': studentDetail['blood_group']},
          {'key': 'Height', 'value': studentDetail['height']},
          {'key': 'Weight', 'value': studentDetail['weight']},
          {
            'key': 'D.O.B',
            'value':
                '${studentDetail['birthdate']}-${studentDetail['birthmonth']}-${studentDetail['birthyear']}'
          },
          {'key': 'Father', 'value': studentDetail['father']},
          {'key': 'Mother', 'value': studentDetail['mother']},
          {'key': 'Nationality', 'value': studentDetail['nationality']},
          {'key': 'Category', 'value': studentDetail['category']},
          {'key': 'Religion', 'value': studentDetail['religion']},
          {'key': 'Primary Mobile', 'value': studentDetail['mobile']},
          {
            'key': 'Alternate Mobile',
            'value': studentDetail['alternate_mobile']
          },
          {'key': 'Email', 'value': studentDetail['email']},
          {'key': 'Address', 'value': studentDetail['street_address']},
          {'key': 'City', 'value': studentDetail['city']},
          {'key': 'State', 'value': studentDetail['state']},
          {'key': 'Pincode', 'value': studentDetail['pincode']}
        ];
      });
    }
  }

  void _fetchDetail() async {
    var profile =
        await sendFetchReq(context, 'fetchStudentDetail', {"status": "1"});
    final photo = await SecuredStorage(myKey: 'studentPhoto').getData();
    if (profile != null) {
      studentListForWidget(profile);
      if (mounted) {
        setState(() {
          studentDetail = profile;
          _isLoading = false;
          image = photo;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Student Profile',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 0, 37, 71),
                  ),
                  height: 165,
                  child: Row(
                    children: [
                      Text(
                          studentDetail['name'] +
                              '\n' +
                              studentDetail['class'] +
                              ' - ' +
                              studentDetail['section'] +
                              '\n' +
                              'Roll no : ${studentDetail['enrolment']}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20)),
                      Container(
                        padding: const EdgeInsets.only(left: 80),
                        height: 160,
                        child: image.toString().isEmpty
                            ? const Icon(
                                Icons.person,
                                size: 100,
                                color: Colors.white,
                              )
                            : Image.network(
                                image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.person,
                                    size: 100,
                                    color: Colors.white,
                                  );
                                },
                              ),
                      )
                    ],
                  ),
                )
                // ListTile(
                //     titleAlignment: ListTileTitleAlignment.top,
                //     contentPadding: const EdgeInsets.symmetric(
                //         horizontal: 30, vertical: 20),
                //     minTileHeight: 100,
                //     tileColor: const Color.fromARGB(255, 0, 37, 71),
                //     title: Text(
                //         studentDetail['name'] +
                //             '\n' +
                //             studentDetail['class'] +
                //             ' - ' +
                //             studentDetail['section'] +
                //             '\n' +
                //             'Roll no : ${studentDetail['enrolment']}',
                //         // 'Roll no : ' +
                //         // studentDetail['enrolment'],
                //         style:
                //             const TextStyle(color: Colors.white, fontSize: 20)),
                //     trailing: SizedBox(
                //         height: 500,
                //         child: image.toString().isEmpty
                //             ? const Icon(
                //                 Icons.person,
                //                 size: 100,
                //                 color: Colors.white,
                //               )
                //             : SizedBox(
                //                 child: Image.network(
                //                   image,
                //                   // width: 180,
                //                   // height: 500,
                //                   // fit: BoxFit.cover,
                //                 ),
                //                 height: double.infinity,
                //               ))),
                ,
                const SizedBox(
                  height: 20,
                ),
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.top,
                  // border: TableBorder.all(),
                  columnWidths: const {
                    0: FlexColumnWidth(3),
                    1: FlexColumnWidth(5)
                  },
                  children: details.map((e) {
                    if (e['value'] == null || e['value'].toString().isEmpty) {
                      return TableRow(children: [
                        TableCell(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            e['key'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        )),
                        const TableCell(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'NA',
                            style: TextStyle(
                              color: Color.fromARGB(255, 243, 87, 76),
                            ),
                          ),
                        )),
                      ]);
                    } else {
                      return TableRow(children: [
                        TableCell(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            e['key'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        )),
                        TableCell(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            e['value'].toString(),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        )),
                      ]);
                    }
                  }).toList(),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 25),
                  child: SizedBox(
                    height: 38,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => StudentDetailsUpdateForm(
                                  studentDetailsList: studentDetail,
                                  defaultImage: image,
                                )));
                      },
                      child: const Text('Update profile'),
                    ),
                  ),
                )
              ],
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
