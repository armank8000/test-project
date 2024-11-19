import 'package:flutter/material.dart';

class MenuItemWidget extends StatelessWidget {
  final String title;
  final IconData myicon;
  final Color mycolor;

  const MenuItemWidget(this.title, this.myicon, this.mycolor, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      width: 88,
      height: 108,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: mycolor.withOpacity(0.3),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                colors: [
                  mycolor.withOpacity(0.0),
                  mycolor.withOpacity(0.05),
                  mycolor.withOpacity(0.1),
                  mycolor.withOpacity(0.2),
                ],
                begin: Alignment.topCenter,
              ),
            ),
            child: Icon(
              myicon,
              size: 54,
              color: mycolor,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: mycolor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
