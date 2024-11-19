import 'package:flutter/material.dart';

import '../screens/notification_details_screen.dart';

class HomepageNoticeboardWidget extends StatefulWidget {
  const HomepageNoticeboardWidget({super.key, required this.noticeBoardList});
  final List<dynamic> noticeBoardList;

  @override
  State<HomepageNoticeboardWidget> createState() =>
      _HomepageNoticeboardWidgetState();
}

class _HomepageNoticeboardWidgetState extends State<HomepageNoticeboardWidget> {
  void _noticeDetail(int id, String tittle) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ids) => NotificationDetailsScreen(
              id: id,
              idTittle: tittle,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // color: const Color.fromARGB(255, 0, 79, 32),
          margin: const EdgeInsets.only(top: 10),
          width: double.infinity,
          child: const Text(
            'NOTICE BOARD',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 79, 32),
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(
            left: 8,
            top: 5,
            right: 8,
            bottom: 12,
          ),
          height: MediaQuery.of(context).size.height * 1 / 4,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 199, 113, 0),
              width: 4,
            ),
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(201, 0, 42, 34),
          ),
          child: Scrollbar(
            child: ListView(
              children: widget.noticeBoardList.map(
                (e) {
                  return InkWell(
                    onTap: () {
                      _noticeDetail(e['id'], e['title']);
                    },
                    child: ListTile(
                      
                      contentPadding: const EdgeInsets.fromLTRB(8, 0, 2, 0),
                      leading: const Card(
                        shape: CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.notifications_active_outlined,
                            color: Color.fromARGB(255, 166, 1, 1),
                            size: 32,
                          ),
                        ),
                      ),
                      title: Text(
                        e['title'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        e['newsDateTime'],
                        style: const TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(232, 234, 233, 233),
                        ),
                      ),
                      trailing: e['newsTag'].toString().isEmpty
                          ? null
                          : Card(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Text(
                                  e['newsTag'],
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 244, 0, 0),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
