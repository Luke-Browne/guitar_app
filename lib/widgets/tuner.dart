import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guitar_app/widgets/tuner_card.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitchdetector/pitchdetector.dart';
import 'package:pitchupdart/instrument_type.dart';
import 'package:pitchupdart/pitch_handler.dart';

class Tuner extends StatefulWidget {
  const Tuner({Key? key}) : super(key: key);

  @override
  _TunerState createState() => _TunerState();
}

class _TunerState extends State<Tuner> {
  Pitchdetector detector = Pitchdetector(sampleRate: 44100, sampleSize: 4096);
  final pitchupDart = PitchHandler(InstrumentType.guitar);
  final pitchDetectorDart = PitchDetector(44100, 1000);

  AudioPlayer audioPlayer = AudioPlayer();

  bool isRecording = false;
  double pitch = 0.0;
  double value = 0.0;
  String note = "C";
  String status = "Awful";

  @override
  void initState() {
    super.initState();
    isRecording = isRecording;

    detector.onRecorderStateChanged.listen((event) {
      double castedPitch = event["pitch"] as double;

      if (castedPitch != -1 && isRecording) {
        //Uses the pitchupDart library to check a given pitch for a Guitar
        final handledPitchResult = pitchupDart.handlePitch(castedPitch);

        String tuningStatus = handledPitchResult.tuningStatus.toString();

        String formattedStatus = displayStatusMessage(tuningStatus);

        //Updates the state with the result
        setState(() {
          note = handledPitchResult.note;
          status = formattedStatus;
          value = calculateStatusValue(tuningStatus);
          pitch = castedPitch;
        });

        if (tuningStatus != 'TuningStatus.undefined') {
          playLocalAsset(tuningStatus == 'TuningStatus.tuned');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            isRecording ? stopRecording() : startRecording();
          },
          child: Container(
            alignment: Alignment.center,
            height: 80,
            width: 320,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black38, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Colors.red,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -5),
                    blurRadius: 10,
                    color: Colors.black26,
                  ),
                ]),
            child:
                // isRecording ? const Icon(Icons.stop) : const Icon(Icons.play_arrow),
                Text(!isRecording ? "Start Tuner" : "Stop Tuner",
                    style: TextStyle(color: Colors.white, fontSize: 35)),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(15),
          width: 100,
          decoration: BoxDecoration(
              color: Colors.blueGrey,
              border: Border.all(color: Colors.grey, width: 3),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Text(
            note,
            style: TextStyle(color: Colors.white, fontSize: 45),
          ),
        ),
        // Expanded(
        TunerCard(
          onPress: () => {},
          colour: Colors.blueGrey,
          cardChild: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(status, style: TextStyle(color: Colors.white, fontSize: 35)),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.black38,
                    inactiveTrackColor: Colors.black45,
                    thumbColor: value == 50.0 ? Colors.green : Colors.red,
                    overlayColor: Colors.deepPurple,
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 15.0),
                    overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 30.0)),
                child: Slider(
                  value: value,
                  min: 0,
                  max: 100,
                  onChanged: (double value) => {},
                ),
              ),
            ],
          ),
        ),

        Text(
          "Pitch Freq in hz: ${pitch.toStringAsFixed(2)}",
          style: TextStyle(color: Colors.blueGrey, fontSize: 18),
        )
      ],
    )));
  }

  String displayStatusMessage(String status) {
    switch (status) {
      case 'TuningStatus.waytoolow':
        return "Way too low";
      case 'TuningStatus.toolow':
        return "Too low";
      case 'TuningStatus.tuned':
        return "In tune";
      case 'TuningStatus.toohigh':
        return "Too high";
      case 'TuningStatus.waytoohigh':
        return "Way too high";

      default:
        return "Awful";
    }
  }

  double calculateStatusValue(String status) {
    switch (status) {
      case 'TuningStatus.waytoolow':
        return 10.0;
      case 'TuningStatus.toolow':
        return 25.0;
      case 'TuningStatus.tuned':
        return 50.0;
      case 'TuningStatus.toohigh':
        return 75.0;
      case 'TuningStatus.waytoohigh':
        return 90.0;

      default:
        return 0.0;
    }
  }

  Future<AudioPlayer> playLocalAsset(bool playGood) async {
    AudioCache cache = AudioCache();

    return await cache.play(!playGood ? "awful-final.mp3" : "good-final.wav");
  }

  void startRecording() async {
    await detector.startRecording();
    if (detector.isRecording) {
      setState(() {
        isRecording = true;
        note = "C";
      });
    }
  }

  void stopRecording() async {
    detector.stopRecording();
    setState(() {
      isRecording = false;
      pitch = 0.0;
    });
  }
}
