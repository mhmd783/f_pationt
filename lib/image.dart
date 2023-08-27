import 'package:flutter/material.dart';

class images extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _images();
  }
}

class _images extends State<images> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 200,
        width: 200,
        child: Image.asset("images/logo.png"),
      ),
    );
  }
}
