import 'package:erp_student_app/models/api_functions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationDetailsScreen extends StatefulWidget {
  const NotificationDetailsScreen(
      {super.key, required this.id, required this.idTittle});
  final int id;
  final String idTittle;

  @override
  State<NotificationDetailsScreen> createState() =>
      _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
  List<dynamic> detailsResponseData = [];

  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    _noticeDetails();
  }

  void _noticeDetails() async {
    var notice =
        await sendFetchReq(context, 'fetchNoticeDetail', {"newsId": widget.id});
    if (notice != null) {
      if (mounted) {
        setState(() {
          detailsResponseData = notice;
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 109, 0, 0),
        title: const Text(
          'Notification Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(),
                child: Center(
                  child: Column(children: [
                    const Divider(
                      color: Color.fromARGB(255, 0, 0, 0),
                      height: 1.5,
                      thickness: 50,
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      color: const Color.fromARGB(255, 109, 0, 0),
                      width: double.infinity,
                      child: Text(
                        detailsResponseData[0]['title'],
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 21,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width - 25,
                      child: Column(
                        children: (detailsResponseData).map((f) {
                          Widget body = const Placeholder();
                          if (f['type'] == 'heading') {
                            body = Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              margin: const EdgeInsets.only(bottom: 12),
                              child: Text(
                                f['content'],
                                style: const TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w700),
                              ),
                            );
                          }
                          if (f['type'] == 'paragraph') {
                            body = Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              child: Text(
                                f['content'],
                                textAlign: TextAlign.justify,
                                style: const TextStyle(fontSize: 16),
                              ),
                            );
                          }
                          if (f['type'] == 'link') {
                            final Uri uri = Uri.parse(f['content']);
                            body = Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    await launchUrl(uri);
                                  },
                                  child: Text(
                                    f['caption'],
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  )),
                            );
                          }
                          if (f['type'] == 'image') {
                            body = Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              child: Card(
                                child: Column(
                                  children: [
                                    Image.network(
                                      f['content'],
                                    ),
                                    Text((f['caption']).toString().isEmpty
                                        ? ''
                                        : f['caption']),
                                  ],
                                ),
                              ),
                            );
                          }
                          return body;
                        }).toList(),
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    Card(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          'Updated on : ${detailsResponseData[0]['newsDateTime']}',
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              color: Color.fromARGB(255, 90, 90, 90)),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
