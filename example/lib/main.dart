// Copyright 2020 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_switch/simple_switch.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isItem1Toggled = false;
  bool _isItem2Toggled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SimpleSwitch(
              value: _isItem1Toggled,
              onChanged: (value) {
                setState(() {
                  _isItem1Toggled = value;
                });
              },
            ),
            SizedBox(height: 12),
            Text("Value: $_isItem1Toggled"),
            SizedBox(height: 24),
            SimpleSwitch(
              value: _isItem2Toggled,
              activeColor: Colors.green,
              inactiveColor: Colors.grey.shade300,
              onChanged: (value) {
                setState(() {
                  _isItem2Toggled = value;
                });
              },
            ),
            SizedBox(height: 12),
            Text("Value: $_isItem2Toggled"),
          ],
        ),
      ),
    );
  }
}
