import 'package:flutter/material.dart';
import 'package:flutter_fft/flutter_fft.dart';

class Tuner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Column(children: <Widget>[
          Container(
        margin: EdgeInsets.all(25),
          child: FlatButton(
            child: Text('', style: TextStyle(fontSize: 20.0),),
            onPressed: () {},
          ),
        ),
        Container(
          margin: EdgeInsets.all(25),
          child: FlatButton(
            child: Text('LogIn', style: TextStyle(fontSize: 20.0),),
            color: Colors.blueAccent,
            textColor: Colors.white,
            onPressed: () {},
          ),
        ),
        ],))
      )
    );
  }
}