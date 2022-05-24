import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guitar_app/widgets/chord_gen.dart';
import 'package:guitar_app/widgets/fretboard.dart';
import 'package:guitar_app/widgets/tuner.dart';
import 'package:guitar_app/icons/guitar_icons_icons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State {
  int currentTab = 0;

  late Widget currentPage;
  late Fretboard fretboard;
  late ChordGen chordGen;
  late Tuner tuner;

  late List<Widget> pages;

  @override
  void initState() {
    fretboard = Fretboard();
    chordGen = ChordGen();
    tuner = Tuner();

    pages = [fretboard, chordGen, tuner];

    currentPage = fretboard;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        toolbarHeight:
            -24, // needed to remove the appBar, could just delete it but above line is required to make the bar with wifi, signal, etc. opaque
      ),
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        onTap: (int index) {
          setState(() {
            currentTab = index;
            currentPage = pages[index];
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(GuitarIcons.two_music_notes, size: 30),
              title: Text("Fretboard")),
          BottomNavigationBarItem(
              icon: Icon(GuitarIcons.generator, size: 30),
              title: Text("Generator")),
          BottomNavigationBarItem(
              icon: Icon(GuitarIcons.sound_bars, size: 30),
              title: Text("Tuner")),
        ],
      ),
    );
  }
}
