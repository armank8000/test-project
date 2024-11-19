import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/api_functions.dart';

class EventCalenderScreen extends StatefulWidget {
  const EventCalenderScreen({super.key, required this.mycolor});
  final Color mycolor;

  @override
  State<EventCalenderScreen> createState() => _EventCalenderScreenState();
}

class _EventCalenderScreenState extends State<EventCalenderScreen> {
  var eventlist = [];
  final Map<String, List> _events = {};
  var _isLoading = true;
  late DateTime calenderStartDate;
  late DateTime calenderEndDate;
  late int totalPresent;
  late int totalAbsent;
  late int totalLeave;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    selectPresentDate();
    _fetchEvent();
  }

  void _fetchEvent() async {
    var events =
        await sendFetchReq(context, 'fetchMyAttendance', {'status': '1'});
    if (events != null) {
      if (mounted) {
        setState(() {
          eventlist = events;
        });
      }
      _loadAttendanceData();
    }
  }

  void _loadAttendanceData() {
    // Parse your attendance data here and populate the _events map
    for (var record in eventlist) {
      String date = record['attend_date'];
      String attendance = record['attend'];
      if (_events[date] == null) {
        _events[date] = [];
      }
      _events[date]!.add(attendance);
    }
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.mycolor,
        title: const Text(
          'Event calendar',
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
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    onDaySelected: _onDaySelected,
                    headerStyle: const HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                    ),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    firstDay: calenderStartDate,
                    lastDay: calenderEndDate,
                    focusedDay: _focusedDay,
                    eventLoader: (day) {
                      final DateFormat formatter = DateFormat('yyyy-MM-dd');
                      final String formatted = formatter.format(day);
                      return _events[formatted] ?? [];
                    },
                    calendarStyle: const CalendarStyle(
                      markersMaxCount: 1,
                      selectedDecoration: BoxDecoration(
                        color: Color.fromARGB(68, 73, 73, 73),
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      todayDecoration: BoxDecoration(
                        color: Colors.blueGrey,
                        shape: BoxShape.circle,
                      ),
                      todayTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      canMarkersOverflow: false,
                      markersAlignment: Alignment.center,
                      defaultTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 9, 9),
                      ),
                      weekendTextStyle: TextStyle(
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
                  const SizedBox(
                    height: 15,
                  ),
                  ...eventlist.map((e) {
                    // print(e['attend'].toString().characters.take(10));
                    if (_selectedDay.toString().isEmpty) {
                      return const ListTile(
                        title: Text('No event found'),
                      );
                    } else if (e['attend_date'].toString().characters ==
                        _selectedDay.toString().characters.take(10)) {
                      return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 5),
                          margin: const EdgeInsets.symmetric(horizontal: 7),
                          decoration: BoxDecoration(border: Border.all()),
                          child: ListTile(
                              leading: const Icon(Icons.event_note),
                              title: Text(
                                e['attend'].toString(),
                                style: const TextStyle(fontSize: 17),
                              )));
                    } else {
                      return const SizedBox();
                    }
                  }),
                ],
              ),
            ),
    );
  }

  Widget _buildMarkers(DateTime date, List events) {
    if (events.isNotEmpty) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: //events.map((event) {
              [
            Container(
              // alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.symmetric(horizontal: 1.5),
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                  // backgroundBlendMode: BlendMode.darken,
                  shape: BoxShape.circle,
                  border: Border.all(width: 2)
                  // color: Color.fromARGB(170, 0, 85, 255),
                  ),
            ),
          ]
          // }).toList(),
          );
    } else {
      return const SizedBox();
    }
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
