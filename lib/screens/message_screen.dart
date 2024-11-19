import 'package:flutter/material.dart';

import 'personal_chat_screen.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key, required this.color});
  final Color color;
  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        titleSpacing: 0,
        title: const Text(
          'Message',
          style: TextStyle(fontSize: 18, color: Colors.white70),
        ),
        actions: const [
          Icon(
            Icons.message,
            size: 22.0,
            color: Colors.white70,
          ),
          SizedBox(width: 8.0),
        ],
        bottom: TabBar(
          labelColor: Colors.white70,
          unselectedLabelColor: Colors.white38,
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 4,
          indicatorColor: Colors.orange,
          tabs: const [
            Tab(
              text: 'Personal',
            ),
            Tab(
              text: 'Class Group',
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          ListView(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PersonalChatScreen()));
                },
                child: const ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 113, 123, 129),
                    radius: 28,
                    child: Icon(
                      Icons.person,
                      size: 32,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  title: Text(
                    'Class Teacher',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    children: [
                      Icon(Icons.done_all),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Hi Sir, Please reply!',
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  trailing: Text('18:06'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 80, right: 20),
                child: Divider(thickness: 1),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PersonalChatScreen()));
                },
                child: const ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 113, 123, 129),
                    radius: 28,
                    child: Icon(
                      Icons.person,
                      size: 32,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  title: Text(
                    'Class Teacher',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    children: [
                      Icon(Icons.done_all),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Hi Sir, Please reply!',
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  trailing: Text('18:06'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 80, right: 20),
                child: Divider(thickness: 1),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PersonalChatScreen()));
                },
                child: const ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 113, 123, 129),
                    radius: 28,
                    child: Icon(
                      Icons.person,
                      size: 32,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  title: Text(
                    'Class Teacher',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    children: [
                      Icon(Icons.done_all),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Hi Sir, Please reply!',
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  trailing: Text('18:06'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 80, right: 20),
                child: Divider(thickness: 1),
              ),
            ],
          ),
          const Text('Second'),
        ],
      ),
    );
  }
}
