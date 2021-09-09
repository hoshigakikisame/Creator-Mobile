import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class RouteTo extends CupertinoPageRoute {
  Widget? newPage;
  RouteTo(
    this.newPage
  ) : super(builder: (BuildContext context) => newPage!);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return FadeTransition(opacity: animation, child: newPage);
  }
}
