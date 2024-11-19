import 'package:erp_student_app/models/api_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeaveApplicationScreen extends StatefulWidget {
  const LeaveApplicationScreen(
      {super.key,
      required this.title,
      required this.myicon,
      required this.mycolor});
  final dynamic title;
  final dynamic myicon;
  final dynamic mycolor;

  @override
  State<LeaveApplicationScreen> createState() => _LeaveApplicationScreenState();
}

class _LeaveApplicationScreenState extends State<LeaveApplicationScreen> {
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
    _fetchAllApplications();
    super.initState();
  }

  void _leaveFromDatePicker() async {
    final firstDate = DateTime.now();
    final lastDate = DateTime(firstDate.year + 1);

    var fromDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDate: DateTime.now(),
    );
    if (fromDate.toString() == 'null') {
      setState(() {
        fromDate = DateTime.now();
      });
    } else {
      setState(() {
        fromPickedDate = DateFormat.yMMMd().format(fromDate!);
        fromPickedDateForServer = fromDate.toString();
      });
    }
  }

  void _leaveTillDatePicker() async {
    final firstDate = DateTime.now();
    final lastDate = DateTime(firstDate.year + 1);
    var leaveTillPickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDate: DateTime.now(),
    );
    if (leaveTillPickedDate.toString() == 'null') {
      setState(() {
        leaveTillPickedDate = DateTime.now();
      });
    } else {
      setState(() {
        tillPickedDate = DateFormat.yMMMd().format(leaveTillPickedDate!);
        tillPickedDateForServer = leaveTillPickedDate.toString();
      });
    }
  }

  _fetchAllApplications() async {
    var application = await sendFetchReq(context, 'fetchMyApplications', {
      "android_ver": "v1.0",
    });
    if (application != null) {
      if (mounted) {
        setState(() {
          applicationList = application;
          _isLoading = false;
        });
      }
    }
  }

  void _sendLeaveRequest() async {
    var fromDate = fromPickedDateForServer.characters.take(10);
    var toDate = tillPickedDateForServer.characters.take(10);
    DateTime fromDateTime = DateTime.parse(fromDate.toString());
    DateTime toDateTime = DateTime.parse(toDate.toString());
    if (toDateTime.isAfter(fromDateTime)) {
      await sendUpdateReq(context, 'applyForLeave', {
        "dateFrom": fromDate.toString(),
        'dateTo': toDate.toString(),
        'subject': subject.text.toString(),
        'content': reason.text.toString()
      });
      setState(() {
        fromPickedDate = 'Select Date';
        tillPickedDate = 'Select Date';
        subject.clear();
        reason.clear();
      });
      _fetchAllApplications();
    } else {
      showMessageBox(context, message: 'Please select a valid date');
    }
  }

  @override
  void dispose() {
    subject.dispose();
    reason.dispose();
    super.dispose();
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
                  'Apply for Leave',
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
                  'All Applications',
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
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Leave From',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        'Leave Till    ',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        fromPickedDate ?? 'Select Date',
                                      ),
                                      Text(
                                        tillPickedDate ?? 'Select Date',
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: _leaveFromDatePicker,
                                        icon: const Icon(
                                          Icons.calendar_month,
                                          size: 30,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: _leaveTillDatePicker,
                                        icon: const Icon(
                                          Icons.calendar_month,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            TextFormField(
                              onTapOutside: (event) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                              minLines: 1,
                              maxLines: 2,
                              maxLength: 80,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: subject,
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
                                labelText: 'Subject',
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
                                  hintText: 'Describe your reason',
                                  prefixIcon: Icon(Icons.description)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (subject.text.length > 10 &&
                                    subject.text.length < 80 &&
                                    reason.text.length > 20 &&
                                    reason.text.length < 360) {
                                  if (fromPickedDate.toString() != 'null' &&
                                      tillPickedDate.toString() != 'null' &&
                                      fromPickedDate.toString() !=
                                          'Select Date' &&
                                      tillPickedDate.toString() !=
                                          'Select Date') {
                                    _sendLeaveRequest();
                                    _fetchAllApplications();
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              content: const Text(
                                                  'Kindly select a valid date'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('Okay'))
                                              ],
                                            ));
                                  }
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            content: const Text(
                                                'Kindly fill the leave request according to the instruction'),
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
                                          value['subject'],
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
                                        left: 12, right: 12),
                                    child: Text(
                                      value['dateFrom'] +
                                          ' to ' +
                                          value['dateTo'] +
                                          ')',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12,
                                        top: 12,
                                        right: 12,
                                        bottom: 12),
                                    child: Text(
                                      value['body'],
                                      style: const TextStyle(fontSize: 14),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 12),
                                    child: Text(
                                      "Applied On: ${value['createdOn']}",
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
                                                    ' Approved',
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
                                                    color: Colors.red,
                                                  ),
                                                  Text(
                                                    ' Rejected',
                                                    style: TextStyle(
                                                      color: Colors.red,
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
