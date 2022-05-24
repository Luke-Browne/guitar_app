import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_guitar_tabs/flutter_guitar_tabs.dart';
import '../API/API.dart';
import 'package:tonic/tonic.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_guitar_tabs/flutter_guitar_tabs.dart' as tab;
import 'package:audioplayers/audioplayers.dart';


String _getChordName(String chord) {
  String name = chord.toString();
  print('getting chord: ' + name);
  return name;
}
String _getTab(String chord){
  String name = chord.toString();
  String tab = '';

  switch(name){
    case 'A Major':
      tab = 'x 0 2 2 2 0';
      break;
    case 'B Major':
      tab = 'x 1 3 3 3 1';
      break;
    case 'C Major':
      tab = 'x 3 2 0 1 0';
      break;
    case 'D Major':
      tab = 'x x 0 2 3 2';
      break;
    case 'E Major':
      tab = '0 2 2 1 0 0';
      break;
    case 'F Major':
      tab = '1 3 3 2 1 1';
      break;
    case 'G Major':
      tab = '3 2 0 0 0 3';
      break;
    case 'A♭ Major':
      tab = '4 6 6 5 4 4';
      break;
    case 'A# Major':
      tab = 'x 1 3 3 3 x';
      break;
    case 'B♭ Major':
      tab = 'x 1 3 3 3 1';
      break;
    case 'B# Major':
      tab = '';
      break;
    case 'C♭ Major':
      tab = '';
      break;
    case 'C# Major':
      tab = 'x x 3 1 2 1';
      break;
    case 'D♭ Major':
      tab = 'x x 3 1 2 1';
      break;
    case 'D# Major':
      tab = 'x x 5 3 4 3';
      break;
    case 'E♭ Major':
      tab = 'x x 5 3 4 3';
      break;
    case 'E# Major':
      tab = '';
      break;
    case 'F♭ Major':
      tab = '';
      break;
    case 'F# Major':
      tab = '2 4 4 3 2 2';
      break;
    case 'G♭ Major':
      tab = '2 4 4 3 2 2';
      break;
    case 'G# Major':
      tab = '4 6 6 5 4';
      break;
    case 'A Minor':
      tab = 'x 0 2 2 1 0';
      break;
    case 'B Minor':
      tab = 'x 2 4 4 3 2';
      break;
    case 'C Minor':
      tab = 'x 3 2 0 1 0';
      break;
    case 'D Minor':
      tab = 'x x 0 2 3 1';
      break;
    case 'E Minor':
      tab = '0 2 2 0 0 0';
      break;
    case 'F Minor':
      tab = '1 3 3 1 1 1';
      break;
    case 'G Minor':
      tab = '3 5 5 3 3 3';
      break;
    case 'A♭ Minor':
      tab = '4 6 6 4 4 4';
      break;
    case 'A# Minor':
      tab = 'x 1 3 3 2 1';
      break;
    case 'B♭ Minor':
      tab = 'x 1 3 3 2 1';
      break;
    case 'B# Minor':
      tab = '';
      break;
    case 'C♭ Minor':
      tab = '';
      break;
    case 'C# Minor':
      tab = 'x 4 6 6 5 4';
      break;
    case 'D♭ Minor':
      tab = 'x 4 6 6 5 4';
      break;
    case 'D# Minor':
      tab = 'x 6 8 8 7 6';
      break;
    case 'E♭ Minor':
      tab = 'x x 4 3 4 2';
      break;
    case 'E# Minor':
      tab = '1 3 3 1 1 1';
      break;
    case 'F♭ Minor':
      tab = '1 3 3 1 1 1';
      break;
    case 'F# Minor':
      tab = '2 4 4 2 2 2';
      break;
    case 'G♭ Minor':
      tab = '2 4 4 2 2 2';
      break;
    case 'G# Minor':
      tab = '4 6 6 4 4 4';
      break;
  }
  return tab;
}

void rebuildAllChildren(BuildContext context) {
  void rebuild(Element el) {
    el.markNeedsBuild();
    el.visitChildren(rebuild);
  }

  (context as Element).visitChildren(rebuild);
}

String _replaceTxt(String txt){

  txt = txt.split('#').join('s');
  txt = txt.split('♭').join('f');
  txt = txt.replaceAll(' ', '');
  return txt;

}

class ChordGen extends StatefulWidget {
  const ChordGen({Key? key}) : super(key: key);

  @override
  _ChordGen createState() => _ChordGen();

}


class _ChordGen extends State<ChordGen> {

  late String newValue;
  String url = '';
  String keyVal = 'C Major';
  String patVal = 'I-V-vi-IV';
  List<String> tabList = [];
  List<String> toPlay = [];
  bool ready = false;


  String CmajURL = '../sounds/Cmaj.mp3';

  AudioPlayer audioPlayer = new AudioPlayer();

  @override
  Widget build(BuildContext context) {
    AudioCache audioCache = new AudioCache(fixedPlayer: audioPlayer);


    var keys = ['C Major', 'C# Major', 'D Major', 'E♭ Major', 'E Major', 'F Major', 'F# Major', 'G Major', 'G# Major', 'A Major', 'B♭ Major', 'B Major'];
    String startKey = 'C Major';
    var patterns = ['I-V-vi-IV', 'I-IV-V-IV', 'ii-V-I-I', '12 Bar Blues', 'I-vi-IV-V', 'Canon'];
    String startPattern = 'I-V-vi-IV';

    var returned;
    List<String> ToDisplay = [];

    return Scaffold(

      body: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Key', style: TextStyle(fontSize: 25)),
                Padding(padding: EdgeInsets.all(0)),
                Text('Pattern', style: TextStyle(fontSize: 25)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                SizedBox(height: 45, width:150,

                    child: DropdownButtonFormField(
                        icon: const Icon(Icons.keyboard_arrow_down),
                        isExpanded: true,
                        value: startKey,

                        // Array list of items
                        items: keys.map((String items) {
                          return DropdownMenuItem(
                            alignment: Alignment.center,
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? changed) {
                          setState(() {
                            keyVal = changed!;
                          });
                        }

                    )
                ),
                SizedBox(height: 45, width: 150,

                    child: DropdownButtonFormField(
                        icon: const Icon(Icons.keyboard_arrow_down),
                        isExpanded: true,
                        value: startPattern,

                        // Array list of items
                        items: patterns.map((String items) {
                          return DropdownMenuItem(
                            alignment: Alignment.center,
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? changed) {
                          setState(() {
                            patVal = changed!;
                          });
                        }

                    )
                )

              ],

            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    url = "http://192.168.1.16:5000/keys?key=";
                    var output = _replaceTxt(keyVal);
                    patVal = patVal.replaceAll(' ', '');

                    var returned = await GetChords(url + output + '&pattern=' + patVal);
                    Map<String, dynamic> display = jsonDecode(returned);
                    List<String> ToDisplay = display.values.toString().split(',');
                    ToDisplay.first = ToDisplay.first.substring(1);
                    print(ToDisplay.first);
                    ToDisplay.last = ToDisplay.last.substring(0, ToDisplay.last.length - 1);
                    setState(() {
                      tabList = [];
                    });
                    ToDisplay.forEach((element) {
                      print('case: ' + element);
                      switch(element){
                        case 'A_maj':{
                          setState(() {
                            tabList.add('A Major');
                          });
                          break;
                        }
                        case 'B_maj':{
                          setState(() {
                            tabList.add('B Major');
                          });
                          break;
                        }
                        case 'C_maj':{
                          setState(() {
                            tabList.add('C Major');
                          });
                          break;
                        }
                        case 'D_maj':{
                          setState(() {
                            tabList.add('D Major');
                          });
                          break;
                        }
                        case 'E_maj':{
                          setState(() {
                            tabList.add('E Major');
                          });
                          break;
                        }
                        case 'F_maj':{
                          setState(() {
                            tabList.add('F Major');
                          });
                          break;
                        }
                        case 'G_maj':{
                          setState(() {
                            tabList.add('G Major');
                          });
                          break;
                        }
                        case 'As_maj':{
                          setState(() {
                            tabList.add('A# Major');
                          });
                          break;
                        }
                        case 'Ab_maj':{
                          setState(() {
                            tabList.add('A♭ Major');
                          });
                          break;
                        }
                        case 'Bs_maj':{
                          setState(() {
                            tabList.add('B# Major');
                          });
                          break;
                        }
                        case 'Bb_maj':{
                          setState(() {
                            tabList.add('B♭ Major');
                          });
                          break;
                        }
                        case 'Cs_maj':{
                          setState(() {
                            tabList.add('C# Major');
                          });
                          break;
                        }
                        case 'Cb_maj':{
                          setState(() {
                            tabList.add('C♭ Major');
                          });
                          break;
                        }
                        case 'Ds_maj':{
                          setState(() {
                            tabList.add('D# Major');
                          });
                          break;
                        }
                        case 'Db_maj':{
                          setState(() {
                            tabList.add('D♭ Major');
                          });
                          break;
                        }
                        case 'Es_maj':{
                          setState(() {
                            tabList.add('E# Major');
                          });
                          break;
                        }
                        case 'Eb_maj':{
                          setState(() {
                            tabList.add('E♭ Major');
                          });
                          break;
                        }
                        case 'Fs_maj':{
                          setState(() {
                            tabList.add('F# Major');
                          });
                          break;
                        }
                        case 'Fb_maj':{
                          setState(() {
                            tabList.add('F♭ Major');
                          });
                          break;
                        }
                        case 'Gs_maj':{
                          setState(() {
                            tabList.add('G# Major');
                          });
                          break;
                        }
                        case 'Gb_maj':{
                          setState(() {
                            tabList.add('G♭ Major');
                          });
                          break;
                        }
                        case 'A_min':{
                          setState(() {
                            tabList.add('A Minor');
                          });
                          break;
                        }
                        case 'B_min':{
                          setState(() {
                            tabList.add('B Minor');
                          });
                          break;
                        }
                        case 'C_min':{
                          setState(() {
                            tabList.add('C Minor');
                          });
                          break;
                        }
                        case 'D_min':{
                          setState(() {
                            tabList.add('D Minor');
                          });
                          break;
                        }
                        case 'E_min':{
                          setState(() {
                            tabList.add('E Minor');
                          });
                          break;
                        }
                        case 'F_min':{
                          setState(() {
                            tabList.add('F Minor');
                          });
                          break;
                        }
                        case 'G_min':{
                          setState(() {
                            tabList.add('G Minor');
                          });
                          break;
                        }
                        case 'As_min':{
                          setState(() {
                            tabList.add('A# Minor');
                          });
                          break;
                        }
                        case 'Ab_min':{
                          setState(() {
                            tabList.add('A♭ Minor');
                          });
                          break;
                        }
                        case 'Bs_min':{
                          setState(() {
                            tabList.add('B# Minor');
                          });
                          break;
                        }
                        case 'Bb_min':{
                          setState(() {
                            tabList.add('B♭ Minor');
                          });
                          break;
                        }
                        case 'Cs_min':{
                          setState(() {
                            tabList.add('C# Minor');
                          });
                          break;
                        }
                        case 'Cb_min':{
                          setState(() {
                            tabList.add('C♭ Minor');
                          });
                          break;
                        }
                        case 'Ds_min':{
                          setState(() {
                            tabList.add('D# Minor');
                          });
                          break;
                        }
                        case 'Db_min':{
                          setState(() {
                            tabList.add('D♭ Minor');
                          });
                          break;
                        }
                        case 'Es_min':{
                          setState(() {
                            tabList.add('E# Minor');
                          });
                          break;
                        }
                        case 'Eb_min':{
                          setState(() {
                            tabList.add('E♭ Minor');
                          });
                          break;
                        }
                        case 'Fs_min':{
                          setState(() {
                            tabList.add('F# Minor');
                          });
                          break;
                        }
                        case 'Fb_min':{
                          setState(() {
                            tabList.add('F♭ Minor');
                          });
                          break;
                        }
                        case 'Gs_min':{
                          setState(() {
                            tabList.add('G# Minor');
                          });
                          break;
                        }
                        case 'Gb_min':{
                          setState(() {
                            tabList.add('G♭ Minor');
                          });
                          break;
                        }
                      }
                    });
                    setState(() {
                      print(tabList);
                    });
                    ready = true;
                  },
                  child: Container(

                      alignment: Alignment.center,
                      height: 80,
                      width: 320,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: Colors.green,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, -5),
                              blurRadius: 10,
                              color: Colors.black26,
                            ),
                          ]),
                      child: Text('Generate!', style: TextStyle(
                          color: Colors.white, fontSize: 35
                      ))
                  ),
                )
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      height: 120,
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                        color: Colors.white60,
                      ),
                      child: Expanded(
                        child: FlutterGuitarTab(name: tabList.isEmpty ? '- - - -' : _getChordName(tabList[0]), tab: tabList.isEmpty ? 'x x x x x 5' : _getTab(tabList[0]), size: 4, color: Colors.black87),
                      )
                  ),
                ),
                Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      height: 120,
                      width: 90,
                      decoration: BoxDecoration(
                          color: Colors.white60
                      ),
                      child: Expanded(
                        child: FlutterGuitarTab(name: tabList.isEmpty ? '- - - -' : _getChordName(tabList[1]), tab: tabList.isEmpty ? 'x x x x x 5' : _getTab(tabList[1]), size: 4, color: Colors.black87),
                      )
                  ),
                ),
                Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      height: 120,
                      width: 90,
                      decoration: BoxDecoration(
                          color: Colors.white60
                      ),
                      child: Expanded(
                        child: FlutterGuitarTab(name: tabList.isEmpty ? '- - - -' : _getChordName(tabList[2]), tab: tabList.isEmpty ? 'x x x x x 5' : _getTab(tabList[2]), size: 4, color: Colors.black87),
                      )
                  ),
                ),
                Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      height: 120,
                      width: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
                          color: Colors.white60
                      ),
                      child: Expanded(
                        child: FlutterGuitarTab(name: tabList.isEmpty ? '- - - -' : _getChordName(tabList[3]), tab: tabList.isEmpty ? 'x x x x x 5' : _getTab(tabList[3]), size: 4, color: Colors.black87),
                      )
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () async{
                    audioCache.play(CmajURL);
                  },
                  child: AbsorbPointer(
                    child: Container(

                        alignment: Alignment.center,
                        height: 80,
                        width: 320,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: ready ? Colors.green : Colors.grey,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, -5),
                                blurRadius: 10,
                                color: Colors.black26,
                              ),
                            ]),
                        child: Text('Play!', style: TextStyle(
                            color: ready ? Colors.white : Colors.black38,
                            fontSize: 35
                        ))
                    ),
                  ),
                )
              ],
            ),
          ]
      )

    );

  }
}