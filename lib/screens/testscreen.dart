import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Screen'),
      ),
      body: GridView(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: [
          Card(
            elevation: 5,
            child: Stack(children: [
              Image.asset('lib/assets/unnamed.jpg'),
              Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(8),
                alignment: Alignment.bottomCenter,
                child: const Text(
                  'Mathematics',
                  style: TextStyle(
                      fontSize: 23, backgroundColor: Colors.transparent),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
