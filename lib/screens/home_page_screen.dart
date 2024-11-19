import 'package:erp_student_app/models/api_functions.dart';
import 'package:erp_student_app/screens/result_screen.dart';
import 'package:erp_student_app/screens/testscreen.dart';
import '../services/notification_services.dart';
import 'package:flutter/material.dart';

import 'assignment_screen.dart';
import 'attendence_screen.dart';
import 'event_calender_screen.dart';
import 'homework_screen.dart';
import 'register_complaint_screen.dart';
import '../widgets/homepage_noticeboard_widget.dart';

import '../models/functions.dart';
import '../widgets/home_page_widgets/drawer_student_detail_widget.dart';
import '../models/menu.dart';
import '../widgets/home_page_widgets/menu_item_widget.dart';
import '../widgets/org_detail_widget.dart';
import 'leave_application_screen.dart';
import 'message_screen.dart';
import 'syllabus_screen.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({super.key});

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  final List<Menu> loadedMenu = [
    Menu(
      id: 'mi1',
      title: 'Message',
      description: 'First',
      myicon: Icons.email,
      mycolor: const Color.fromARGB(255, 246, 87, 76),
    ),
    Menu(
      id: 'mi2',
      title: 'Assignment',
      description: 'Third',
      myicon: Icons.assignment,
      mycolor: Colors.lightBlue,
    ),
    Menu(
      id: 'mi3',
      title: 'Homework',
      description: 'Third',
      myicon: Icons.home_work,
      mycolor: const Color.fromARGB(255, 0, 70, 5),
    ),
    Menu(
      id: 'mi4',
      title: 'Result',
      description: 'Third',
      myicon: Icons.rule_sharp,
      mycolor: Colors.teal,
    ),
    Menu(
      id: 'mi6',
      title: 'Syllabus',
      description: 'Fourth',
      myicon: Icons.library_books,
      mycolor: const Color.fromARGB(255, 95, 115, 227),
    ),
    Menu(
      id: 'mi7',
      title: 'Time Table',
      description: 'Fifth',
      myicon: Icons.timer,
      mycolor: const Color.fromARGB(255, 245, 103, 150),
    ),
    Menu(
      id: 'mi8',
      title: 'Leave Request',
      description: 'Sixth',
      myicon: Icons.time_to_leave,
      mycolor: const Color.fromARGB(255, 0, 59, 72),
    ),
    Menu(
      id: 'mi9',
      title: 'Attendance',
      description: 'Seventh',
      myicon: Icons.assignment_turned_in,
      mycolor: Colors.green,
    ),
    Menu(
      id: 'mi10',
      title: 'Event Calendar',
      description: 'Fifth',
      myicon: Icons.calendar_month,
      mycolor: const Color.fromARGB(255, 1, 62, 126),
    ),
    Menu(
      id: 'mi11',
      title: 'Register Complaint',
      description: 'Fifth',
      myicon: Icons.sd_card_alert,
      mycolor: const Color.fromARGB(255, 178, 0, 0),
    ),
    Menu(
      id: 'mi12',
      title: 'FAQ',
      description: 'Eighth',
      myicon: Icons.question_mark,
      mycolor: const Color.fromARGB(255, 0, 13, 255),
    ),
  ];
  @override
  void initState() {
    NotificationServices().requestPermission();
    NotificationServices().getDeviceToken();
    NotificationServices().initLocalNotification();
    NotificationServices().openFromTerminateState();
    _noticeBoard();

    super.initState();
  }

  var studentName = '';
  var studentClass = '';
  var studentSection = '';
  var studentRoll = '';
  var studentPhoto = '';
  List<dynamic> noticeBoardList = [];

  _setStudentDetail() async {
    final name = await SecuredStorage(myKey: 'studentName').getData();
    final std = await SecuredStorage(myKey: 'studentClass').getData();
    final sec = await SecuredStorage(myKey: 'studentSection').getData();
    final roll = await SecuredStorage(myKey: 'studentRoll').getData();
    final photo = await SecuredStorage(myKey: 'studentPhoto').getData();
    setState(() {
      studentName = name.toString();
      studentClass = std.toString();
      studentSection = sec.toString();
      studentRoll = roll.toString();
      studentPhoto = photo.toString();
    });
  }

  void _noticeBoard() async {
    var noticelist =
        await sendFetchReq(context, 'fetchNoticeBoard', {'status': '1'});
    if (noticelist != null) {
      _setStudentDetail();
      noticelist = noticelist.reversed.toList();
      if (mounted) {
        setState(() {
          noticeBoardList = noticelist;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 4,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 109, 0, 0),
        leadingWidth: double.infinity,
        leading: Builder(builder: (context) {
          return InkWell(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: Image.network(
                      studentPhoto,
                      // height: 95,
                      // width: 90,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.person,
                          color: Colors.black,
                        );
                      },
                    ).image,
                  ),
                  Text(
                    ' $studentName',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
      drawer: DrawerStudentDetailWidget(
        name1: studentName,
        name2: studentClass,
        name3: studentSection,
        name4: studentRoll,
        name5: studentPhoto,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomepageNoticeboardWidget(
              noticeBoardList: noticeBoardList,
            ),
            const Divider(),
            Container(
              margin: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.center,
                spacing: 0.0, // gap between adjacent chips
                runSpacing: 0.0,
                children: (loadedMenu)
                    .map(
                      (menuItem) => InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) {
                                if (menuItem.id == 'mi1') {
                                  return MessageScreen(
                                    color: menuItem.mycolor,
                                  );
                                } else if (menuItem.id == 'mi2') {
                                  return const AssignmentScreen();
                                } else if (menuItem.id == 'mi3') {
                                  return HomeworkScreen(
                                    color: menuItem.mycolor,
                                  );
                                } else if (menuItem.id == 'mi4') {
                                  return const ResultScreen();
                                } else if (menuItem.id == 'mi8') {
                                  return LeaveApplicationScreen(
                                    title: menuItem.title,
                                    myicon: menuItem.myicon,
                                    mycolor: menuItem.mycolor,
                                  );
                                } else if (menuItem.id == 'mi6') {
                                  return const SyllabusScreen();
                                } else if (menuItem.id == 'mi10') {
                                  return EventCalenderScreen(
                                      mycolor: menuItem.mycolor);
                                } else if (menuItem.id == 'mi11') {
                                  return RegisterComplaintScreen(
                                      title: menuItem.title,
                                      myicon: menuItem.myicon,
                                      mycolor: menuItem.mycolor);
                                } else if (menuItem.id == 'mi9') {
                                  return const AttendenceScreen();
                                } else if (menuItem.id == 'mi12') {
                                  return const MyWidget();
                                } else {
                                  return const SyllabusScreen();
                                }
                              },
                            ),
                          );
                        },
                        child: MenuItemWidget(
                          menuItem.title,
                          menuItem.myicon,
                          menuItem.mycolor,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const OrgDetailWidget(
        Color.fromARGB(255, 109, 0, 0),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        onPressed: () {},
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(
              'https://navjyotimodelschool.com/webcontent/rv20240320AM0259051710883745423565fa03a167666.png'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
