import 'package:flutter/material.dart';
import '../widgets/org_detail_widget.dart';

class SubMenu extends StatelessWidget {
  final String menuTitle;
  final IconData menuIcon;
  final Color menuColor;
  const SubMenu(this.menuTitle, this.menuIcon, this.menuColor, {super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          menuTitle,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          Icon(
            menuIcon,
            size: 28.0,
            color: Colors.white,
          ),
          const SizedBox(width: 8.0),
        ],
        backgroundColor: menuColor,
      ),
      bottomNavigationBar: OrgDetailWidget(menuColor),
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
