import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(navigationBar: CupertinoNavigationBar(backgroundColor: CupertinoColors.systemGrey.withOpacity(0.5),middle: Text('More'),),child: Column(children: [Text("some data")],));
  }
}