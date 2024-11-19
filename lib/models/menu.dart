import 'package:flutter/cupertino.dart';

class Menu {
  String? id;
  dynamic title;
  String? description;
  dynamic myicon;
  dynamic mycolor;

  Menu({
    @required this.id,
    @required this.title,
    this.description,
    this.myicon,
    this.mycolor,
  });
}
