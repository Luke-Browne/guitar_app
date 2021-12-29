import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guitar_app/widgets/chord_gen.dart';
import 'package:guitar_app/widgets/fretboard.dart';
import 'package:guitar_app/widgets/tuner.dart';
import 'package:guitar_app/icons/guitar_icons_icons.dart';

class Home extends StatefulWidget {
  @override
  State createState() {
    return _HomeState();
  }
}

class _HomeState extends State {
  int _pageIndex = 0;
  late PageController _pageController;

  List<Widget> tabPages = [
    Fretboard(),
    ChordGen(),
    Tuner(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        toolbarHeight: -24, // needed to remove the appBar, could just delete it but above line is required to make the bar with wifi, signal, etc. opaque
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: onTabTapped,
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
      body: PageView(
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.decelerate);
  }
}
