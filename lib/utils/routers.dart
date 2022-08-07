import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageNavigator {
  BuildContext? ctext;
  PageNavigator({this.ctext});

  Future nextPage({Widget? page}) {
    return Navigator.push(
        ctext!, CupertinoPageRoute(builder: ((context) => page!)));
  }

  void nextPageOnly({Widget? page}) {
    Navigator.pushAndRemoveUntil(ctext!,
        MaterialPageRoute(builder: (context) => page!), (route) => false);
  }

  void previousPage({Widget? page}) {
    return Navigator.pop(
        ctext!, CupertinoPageRoute(builder: ((context) => page!)));
  }
}
