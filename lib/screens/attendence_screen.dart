// import 'dart:convert';

import 'package:erp_student_app/models/api_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

// import 'package:http/http.dart' as http;
// import '../models/functions.dart';
// import 'login_screen.dart';

class AttendenceScreen extends StatefulWidget {
  const AttendenceScreen({super.key});

  @override
  State<AttendenceScreen> createState() => _AttendenceScreenState();
}

class _AttendenceScreenState extends State<AttendenceScreen> {
  var attendanceList = [];
  final Map<String, List> _events = {};
  var _isLoading = true;
  late DateTime calenderStartDate;
  late DateTime calenderEndDate;
  late int totalPresent;
  late int totalAbsent;
  late int totalLeave;

  @override
  void initState() {
    super.initState();
    selectPresentDate();
    _fetchMyAttendance();
  }

  void _fetchMyAttendance() async {
    var attendance =
        await sendFetchReq(context, 'fetchMyAttendance', {'status': '1'});
    if (attendance != null) {
      if (mounted) {
        setState(() {
          attendanceList = attendance;
        });
      }
      _calculateTotalAttendance(attendanceList);
      _loadAttendanceData();
    }
  }

  void _loadAttendanceData() {
    // Parse your attendance data here and populate the _events map
    for (var record in attendanceList) {
      String date = record['attend_date'];
      String attendance = record['attend'];
      // if (_events[date] == null) {_events[date] = []; }
      _events[date] = [attendance];
    }
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  _calculateTotalAttendance(attendanceLists) {
    var pList = [];
    var aList = [];
    var lList = [];
    for (var e in attendanceLists) {
      if (e['attend'].toString() == 'P') {
        pList.add(e['attend']);
      } else if (e['attend'].toString() == 'A') {
        aList.add(e['attend']);
      } else {
        lList.add(e['attend']);
      }
    }
    if (mounted) {
      setState(() {
        totalPresent = pList.length;
        totalAbsent = aList.length;
        totalLeave = lList.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Attendance Calendar',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  TableCalendar(
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                    ),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    firstDay: calenderStartDate,
                    lastDay: calenderEndDate,
                    focusedDay: DateTime.now(),
                    eventLoader: (day) {
                      final DateFormat formatter = DateFormat('yyyy-MM-dd');
                      final String formatted = formatter.format(day);
                      return _events[formatted] ?? [];
                    },
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        border: Border.all(width: 3),
                      ),
                      todayTextStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      markersAnchor: BorderSide.strokeAlignOutside,
                      canMarkersOverflow: true,
                      markersAlignment: Alignment.center,
                      defaultTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 9, 9),
                      ),
                      weekendTextStyle: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: Colors.red),
                    ),
                    weekendDays: const [DateTime.sunday],
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, date, events) {
                        if (events.isEmpty) {
                          return const SizedBox();
                        }
                        return _buildMarkers(date, events);
                      },
                    ),
                  ),
                  const Divider(
                    height: 8,
                    thickness: 2,
                  ),
                  const Divider(
                    height: 3,
                    thickness: 2,
                  ),
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 13,
                    ),
                    title: Text(
                        'Total Present:  ${totalPresent.toString()} out of ${totalPresent + totalAbsent + totalLeave} days'),
                  ),
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 13,
                    ),
                    title: Text(
                        'Total Absent:  ${totalAbsent.toString()} out of ${totalPresent + totalAbsent + totalLeave} days'),
                  ),
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 13,
                    ),
                    title: Text(
                        'Total Leave:  ${totalLeave.toString()} out of ${totalPresent + totalAbsent + totalLeave} days'),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildMarkers(DateTime date, List events) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: events.map((event) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 1.5),
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            backgroundBlendMode: BlendMode.darken,
            shape: BoxShape.circle,
            // color: event ? Colors.green : Colors.red,
            color: selectColor(event),
          ),
        );
      }).toList(),
    );
  }

  void selectPresentDate() {
    if (DateTime.now().month.toInt() > 3) {
      setState(() {
        calenderStartDate = DateTime(DateTime.now().year, 3, 1);
        calenderEndDate = DateTime(DateTime.now().year + 1, 3, 31);
      });
    } else {
      setState(() {
        calenderStartDate = DateTime(DateTime.now().year - 1, 3, 1);
        calenderEndDate = DateTime(DateTime.now().year, 3, 31);
      });
    }
  }
}

selectColor(event) {
  if (event == 'P') {
    return Colors.green;
  } else if (event == 'A') {
    return Colors.red;
  } else if (event == 'L') {
    return Colors.grey;
  } else {
    return Colors.white;
  }
}
