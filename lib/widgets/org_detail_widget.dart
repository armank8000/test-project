import 'package:flutter/material.dart';

class OrgDetailWidget extends StatelessWidget {
  final Color menuColor;
  const OrgDetailWidget(this.menuColor, {super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 105,
      color: menuColor,
      shape: const CircularNotchedRectangle(),
      child: Container(
        width: double.maxFinite,
        height: 92.0,
        margin: const EdgeInsets.only(
          top: 18,
        ),
        padding: const EdgeInsets.only(
          top: 0,
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Navjyoti Model School',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              'Where we create achievers.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
