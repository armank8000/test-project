import 'package:flutter/material.dart';

class PersonalChatScreen extends StatefulWidget {
  const PersonalChatScreen({super.key});

  @override
  State<PersonalChatScreen> createState() => _PersonalChatScreenState();
}

class _PersonalChatScreenState extends State<PersonalChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 147, 255, 250),
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 75,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back,
                size: 24,
              ),
              SizedBox(
                width: 5,
              ),
              CircleAvatar(
                backgroundColor: Color.fromARGB(255, 113, 123, 129),
                child: Icon(
                  Icons.person,
                  color: Colors.white70,
                  size: 36,
                ),
              ),
            ],
          ),
        ),
        title: Container(
          margin: const EdgeInsets.all(8),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Class Teacher',
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Last seen today at 12:00 PM',
                style: TextStyle(color: Colors.white70, fontSize: 12.5),
              ),
            ],
          ),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            ListView(
              children: const [],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 55,
                    child: Card(
                      margin:
                          const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 6,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type your message...',
                            prefixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.emoji_emotions)),
                            contentPadding: const EdgeInsets.all(5)),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: CircleAvatar(
                      radius: 25,
                      child: Icon(Icons.send),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
