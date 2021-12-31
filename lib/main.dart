import 'package:flutter/material.dart';
import 'package:guitar_app/widgets/tuner.dart';
import 'home_widget.dart';

void main() async => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // removes debug banner in top left corner
      theme: ThemeData.dark(),
      title: 'Guitar Buddy',
      home: Home(),
    );
  }
}
