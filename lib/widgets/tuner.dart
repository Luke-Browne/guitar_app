import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        },),
        flutterFft.setTolerance = 1.0,
        flutterFft.setNote = note!,
        flutterFft.setFrequency = frequency!,
        flutterFft.setOctave = octave!,
        print("Octave: ${octave!.toString()}"),
        sleep(const Duration(milliseconds: 50)),

    // tried to use switch statement here but for some reason it wasn't working, yet an if statement does???
    if(note == "E" && octave == 2)
    {
      flutterFft.setTarget = 82.41,
      print("Current Target frequency : ${flutterFft.getTarget}")
    }else if(note == "A" && octave == 2){
      flutterFft.setTarget = 110,
      print("Current Target frequency : ${flutterFft.getTarget}")
    }else if(note == "D" && octave == 3){
      flutterFft.setTarget = 146.83,
      print("Current Target frequency : ${flutterFft.getTarget}")
    }else if(note == "G" && octave == 3){
      flutterFft.setTarget = 196.00,
      print("Current Target frequency : ${flutterFft.getTarget}")
    }else if(note == "B" && octave == 3){
      flutterFft.setTarget = 246.94,
      print("Current Target frequency : ${flutterFft.getTarget}")
    }else if(note == "E" && octave == 4){
      flutterFft.setTarget = 329.63,
      print("Current Target frequency : ${flutterFft.getTarget}")
    }},

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

    var standardTuning = ["E4", "B3", "G3", "D3", "A2", "E2"];

    flutterFft.setTuning = standardTuning;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.175,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                          minimumSize: Size(200, 50),
                          maximumSize: Size(250, 60)),
                      child: Text('Start Tuner'),
                      onPressed: () async {
                        _initialize();
                      }),
                ],
              ),
            ),
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.665,
              color: Colors.grey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      isRecording!
                          ? Text(
                        "Current Note : ${note!.toString()}",
                        style: TextStyle(fontSize: 30),
                      )
                          : Text(
                          "Not Recording", style: TextStyle(fontSize: 35))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      isRecording!
                          ? Text(
                          "Current frequency: ${frequency!.toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 30))
                          : Text("tuning: ${flutterFft.getTuning}",
                          style: TextStyle(fontSize: 25))
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

