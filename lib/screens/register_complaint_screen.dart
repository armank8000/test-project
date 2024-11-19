import 'package:erp_student_app/models/api_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterComplaintScreen extends StatefulWidget {
  const RegisterComplaintScreen(
      {super.key,
      required this.title,
      required this.myicon,
      required this.mycolor});
  final dynamic title;
  final dynamic myicon;
  final dynamic mycolor;

  @override
  State<RegisterComplaintScreen> createState() =>
      _LeaveApplicationScreenState();
}

class _LeaveApplicationScreenState extends State<RegisterComplaintScreen> {
  List applicationList = [];
  dynamic tillPickedDate;
  dynamic fromPickedDate;
  var tillPickedDateForServer = '';
  var fromPickedDateForServer = '';
  final formatter = DateFormat.yMd();
  final subject = TextEditingController();
  final reason = TextEditingController();
  var _isLoading = true;

  @override
  void initState() {
    _fetchAllComplaints();
    super.initState();
  }

  _fetchAllComplaints() async {
    var complaint =
        await sendFetchReq(context, 'fetchMyComplaints', {'status': '1'});
    if (complaint != null) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          applicationList = complaint;
        });
      }
    }
  }

  void _sendComplaint() async {
    await sendUpdateReq(context, 'createComplaint', {
      'complaint_about': subject.text.toString(),
      'complaint_detail': reason.text.toString()
    });
    subject.clear();
    reason.clear();
  }

  @override
  void dispose() {
    super.dispose();
    subject.dispose();
    reason.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          actions: [
            Icon(
              widget.myicon,
              size: 24.0,
              color: Colors.white,
            ),
            const SizedBox(width: 8.0),
          ],
          backgroundColor: widget.mycolor,
          bottom: const TabBar(
            unselectedLabelColor: Colors.white54,
            labelColor: Colors.white,
            indicatorColor: Color.fromARGB(255, 255, 127, 7),
            indicatorWeight: 5.0,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.white,
            dividerHeight: 5,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.add_card,
                ),
                child: Text(
                  'Register a complaint',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.list,
                ),
                child: Text(
                  'All Complaints',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : TabBarView(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 15, top: 12, right: 15, bottom: 15),
                    child: SingleChildScrollView(
                      child: Form(
                        // autovalidateMode: AutovalidateMode.onUserInteraction, 
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(border: Border.all()),
                              width: double.infinity,
                              child: const Text(
                                '* You can register any complain here.\n* Your identity will be kept secret. \n* This complain can only be seen by Admin. \n* If you see acknowledged on the Complaints tab \n  it means complaint is registered.',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            TextFormField(
                              minLines: 1,
                              maxLines: 2,
                              maxLength: 80,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: subject,
                              onTapOutside: (event) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                              validator: (subject) {
                                if (subject != null) {
                                  if (subject.length < 10 ||
                                      subject.length > 80) {
                                    return 'Minimum 10 and maximum 80 characters are allowed';
                                  }
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Complain About',
                                prefixIcon: Icon(Icons.mail),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              maxLength: 360,
                              minLines: 2,
                              maxLines: 8,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: reason,
                              onTapOutside: (event) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                              validator: (mainBody) {
                                if (mainBody != null) {
                                  if (mainBody.length < 20 ||
                                      mainBody.length > 360) {
                                    return 'Minimum 20 and maximum 360 characters are allowed';
                                  }
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Describe',
                                  hintText: 'Describe your complain',
                                  prefixIcon: Icon(Icons.description)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (subject.text.length > 10 &&
                                    subject.text.length < 80 &&
                                    reason.text.length > 20 &&
                                    reason.text.length < 360) {
                                  _sendComplaint();
                                  _fetchAllComplaints();
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            content: const Text(
                                                'Kindly fill the complaint request appropriately'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Okay'))
                                            ],
                                          ));
                                }
                              },
                              child: const Text('Submit'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // SECOND TAB STARTS HERE
                  SingleChildScrollView(
                    // width: double.infinity,
                    // padding: const EdgeInsets.all(12),
                    child: Column(
                      children: applicationList.reversed
                          .map(
                            (value) => ListTile(
                              contentPadding: const EdgeInsets.only(
                                  left: 0, top: 0, right: 0, bottom: 0),
                              shape: Border(
                                bottom: BorderSide(
                                  color: widget.mycolor,
                                  width: 3,
                                ),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Card(
                                      color: widget.mycolor,
                                      shadowColor: Colors.black,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                          value['complaint_about'].toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12,
                                        top: 12,
                                        right: 12,
                                        bottom: 12),
                                    child: Text(
                                      value['complaint_detail'].toString(),
                                      style: const TextStyle(fontSize: 14),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 12),
                                    child: Text(
                                      "Applied On: ${value['created_on']}",
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Builder(
                                          builder: (BuildContext context) {
                                        if (value['leave_status'].toString() ==
                                            '1') {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Row(
                                                children: [
                                                  Icon(
                                                    Icons.check_box,
                                                    color: Colors.green,
                                                  ),
                                                  Text(
                                                    ' Resolved',
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                  "By: ${value['approvedBy']}"),
                                              Text(
                                                  "On: ${value['approvedOn']}"),
                                            ],
                                          );
                                        } else if (value['leave_status']
                                                .toString() ==
                                            '2') {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Row(
                                                children: [
                                                  Icon(
                                                    Icons.cancel,
                                                    color: Color.fromARGB(
                                                        255, 0, 154, 215),
                                                  ),
                                                  Text(
                                                    ' Acknowledged',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 144, 234),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                  "By: ${value['approvedBy']}"),
                                              Text(
                                                  "On: ${value['approvedOn']}"),
                                            ],
                                          );
                                        } else {
                                          return const Row(
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                color: Colors.orange,
                                              ),
                                              Text(
                                                ' Pending',
                                                style: TextStyle(
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
