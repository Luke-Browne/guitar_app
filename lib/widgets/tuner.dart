import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_fft/flutter_fft.dart';

class Tuner extends StatefulWidget {
  const Tuner({Key? key}) : super(key: key);

  @override
  _TunerState createState() => _TunerState();
}

class _TunerState extends State<Tuner> {
  double? frequency;

  String? note;

  int? octave;

  bool? isRecording;

  FlutterFft flutterFft = FlutterFft();

  _initialize() async {
    // Keep asking for mic permission until accepted
  //  while (!(await flutterFft.checkPermission())) {
   //   flutterFft.requestPermission();
      // IF DENY QUIT PROGRAM
  //  }

    // await flutterFft.checkPermissions();
    await flutterFft.startRecorder();
    print("Recorder started...");
    setState(() => isRecording = flutterFft.getIsRecording);

    flutterFft.onRecorderStateChanged.listen(
        (data) => {
              print("Changed state, received: $data"),
              setState(
                () => {
                  frequency = data[1] as double,
                  note = data[2] as String,
                  octave = data[5] as int,
                },
              ),
              flutterFft.setNote = note!,
              flutterFft.setFrequency = frequency!,
              flutterFft.setOctave = octave!,
              print("Octave: ${octave!.toString()}"),
              sleep(const Duration(milliseconds: 50))
            },
        onError: (err) {
          print("Error: $err");
        },
        onDone: () => {print("Isdone")});
  }

  @override
  void initState() {
    isRecording = flutterFft.getIsRecording;
    frequency = flutterFft.getFrequency;
    note = flutterFft.getNearestNote;
    octave = flutterFft.getOctave;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.grey), child: Text('Standard'), onPressed: () {}),
                  ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.grey), child: Text(''), onPressed: () {}),
                  ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.grey), child: Text(''), onPressed: () {}),
                ],
              ),
              ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.grey), child: Text('Start Tuner'), onPressed: () async {
                _initialize();
              }),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.665,
          color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  isRecording!
                      ? Text("Current note: ${note!}",
                      style: TextStyle(fontSize: 30))
                      : Text("Not Recording", style: TextStyle(fontSize: 35))
                ],
              ),
              isRecording!
                  ? Text(
                  "Current frequency: ${frequency!.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 30))
                  : Text("", style: TextStyle(fontSize: 35))
            ],
          ),
        )
      ],
    ));
  }
}
