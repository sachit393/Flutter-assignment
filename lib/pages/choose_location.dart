import 'package:flutter/material.dart';

class ChooseLoctaion extends StatefulWidget {
  @override
  _ChooseLoctaionState createState() => _ChooseLoctaionState();
}

class _ChooseLoctaionState extends State<ChooseLoctaion> {
  int count = 0;
  @override
  void initState() {
    super.initState();
    print('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Text('choose a location'),
          centerTitle: true,
        ),
        body: RaisedButton(
            onPressed: () {
              setState(() {
                count += 1;
              });
            },
            child: Text('counter is $count')));
  }
}
