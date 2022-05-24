import 'package:flutter/material.dart';

class Fretboard extends StatefulWidget {
  const Fretboard({Key? key}) : super(key: key);

  @override
  _FretboardState createState() => _FretboardState();
}

class _FretboardState extends State<Fretboard> {
  List<String> notes = [
    "Fret",
    "1ˢᵗ",
    "2ⁿᵈ",
    "3ʳᵈ",
    "4ᵗʰ",
    "5ᵗʰ",
    "6ᵗʰ",
    "7ᵗʰ",
    "8ᵗʰ",
    "9ᵗʰ",
    "10ᵗʰ",
    "11ᵗʰ",
    "12ᵗʰ",
    "E",
    "F",
    "F♯",
    "G",
    "G♯",
    "A",
    "A♯",
    "B",
    "C",
    "C♯",
    "D",
    "D♯",
    "E",
    "B",
    "C",
    "C♯",
    "D",
    "D♯",
    "E",
    "F",
    "F♯",
    "G",
    "G♯",
    "A",
    "A♯",
    "B",
    "G",
    "G♯",
    "A",
    "A♯",
    "B",
    "C",
    "C♯",
    "D",
    "D♯",
    "E",
    "F",
    "F♯",
    "G",
    "D",
    "D♯",
    "E",
    "F",
    "F♯",
    "G",
    "G♯",
    "A",
    "A♯",
    "B",
    "C",
    "C♯",
    "D",
    "A",
    "A♯",
    "B",
    "C",
    "C♯",
    "D",
    "D♯",
    "E",
    "F",
    "F♯",
    "G",
    "G♯",
    "A",
    "E",
    "F",
    "F♯",
    "G",
    "G♯",
    "A",
    "A♯",
    "B",
    "C",
    "C♯",
    "D",
    "D♯",
    "E"
  ];
  List<String> frets = [
    "Fret",
    "1ˢᵗ",
    "2ⁿᵈ",
    "3ʳᵈ",
    "4ᵗʰ",
    "5ᵗʰ",
    "6ᵗʰ",
    "7ᵗʰ",
    "8ᵗʰ",
    "9ᵗʰ",
    "10ᵗʰ",
    "11ᵗʰ",
    "12ᵗʰ",
  ];
  List<String> hiENotes = [
    "e",
    "F",
    "F♯",
    "G",
    "G♯",
    "A",
    "A♯",
    "B",
    "C",
    "C♯",
    "D",
    "D♯",
    "E",
  ];
  List<String> BNotes = [
    "B",
    "C",
    "C♯",
    "D",
    "D♯",
    "E",
    "F",
    "F♯",
    "G",
    "G♯",
    "A",
    "A♯",
    "B",
  ];
  List<String> GNotes = [
    "G",
    "G♯",
    "A",
    "A♯",
    "B",
    "C",
    "C♯",
    "D",
    "D♯",
    "E",
    "F",
    "F♯",
    "G",
  ];
  List<String> DNotes = [
    "D",
    "D♯",
    "E",
    "F",
    "F♯",
    "G",
    "G♯",
    "A",
    "A♯",
    "B",
    "C",
    "C♯",
    "D",
  ];
  List<String> ANotes = [
    "A",
    "A♯",
    "B",
    "C",
    "C♯",
    "D",
    "D♯",
    "E",
    "F",
    "F♯",
    "G",
    "G♯",
    "A",
  ];
  List<String> ENotes = [
    "E",
    "F",
    "F♯",
    "G",
    "G♯",
    "A",
    "A♯",
    "B",
    "C",
    "C♯",
    "D",
    "D♯",
    "E"
  ];

  Color _containerColor(List<String> row, int index) {
    if (index == 0 || row[0] == "Fret") {
      return Colors.black;
    } else
      return Colors.white;
  }

  Color _change(List<String> row, int index, List<int> i) {
    if (i.contains(index) && index != 0) {
      return Colors.red;
    } else if (index == 0 || row[0] == "Fret") {
      return Colors.black;
    } else
      return Colors.white;
  }

  Color _textColor(List<String> row, int index) {
    if (index % 13 == 0 || row[0] == "Fret")
      return Colors.white;
    else
      return Colors.black;
  }

  Color _borderColor(List<String> row, int index) {
    return Colors.black38;
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  Color _changeWithKey(List<String> notes, int index, List<int> selected, List<String> keyNotes, int string){
    print(notes);
    print(index);
    print(selected);
    print(keyNotes);

    List<String> _notes = [];
    List<String> _noteNames = [];
    List<int> _stringNum = [];

    _keyNoteMap(List<String> keyNotes){
      for(int i = 0; i < keyNotes.length; i++){
        _notes.add(keyNotes[i]);
        _noteNames.add(_notes[i].toString().substring(0,1));
        _stringNum.add(int.parse(_notes[i].toString().substring(1)));
      }
    }
    _chooseColor(List<int> nums, int index, int a, int b){
      if(nums.sublist(a, b).contains(index)){
        return Colors.redAccent;
      }else if(index == 0){
        return Colors.black;
      }else{
        return Colors.blueGrey;
      }
    }
    _keyNoteMap(keyNotes);

    switch(string){
      case 1: {
        return _chooseColor(_stringNum, index, 0, 7);
      }
      case 2: {
        return _chooseColor(_stringNum, index, 7, 14);
      }
      case 3: {
        return _chooseColor(_stringNum, index, 14, 21);
      }
      case 4: {
        return _chooseColor(_stringNum, index, 21, 28);
      }
      case 5: {
        return _chooseColor(_stringNum, index, 28, 35);
      }
      case 6: {
        return _chooseColor(_stringNum, index, 35, 42);
      }
    }
    return Colors.brown;
  }

  List<String> selectedNotes = [];
  List<String> keyNotes = [];

  List<int> selectedHighE = [];
  List<int> selectedB = [];
  List<int> selectedG = [];
  List<int> selectedD = [];
  List<int> selectedA = [];
  List<int> selectedE = [];

  bool pressAttentionHighE = false;
  bool pressAttentionB = false;
  bool pressAttentionG = false;
  bool pressAttentionD = false;
  bool pressAttentionA = false;
  bool pressAttentionE = false;

  double size = 20;

  int i = 0;

  Color _color = Colors.white12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 40),
          Text('Select Key', style: TextStyle(fontSize: 30)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: new Text("All"),
                onPressed: () {
                  setState(() {
                    keyNotes = [];
                  });
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey, textStyle: TextStyle(fontSize: 30)),
              ),
              ElevatedButton(
                  child: new Text("C"),
                  onPressed: () {
                    setState(() {
                      keyNotes = _buttonClick(1);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      textStyle: TextStyle(fontSize: 30))),
              ElevatedButton(
                  child: new Text("D"),
                  onPressed: () {
                    setState(() {
                      keyNotes = _buttonClick(2);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      textStyle: TextStyle(fontSize: 30))),
              ElevatedButton(
                  child: new Text("E"),
                  onPressed: () {
                    setState(() {
                      keyNotes = _buttonClick(3);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.grey, textStyle: TextStyle(fontSize: 30)))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: new Text("F"),
                onPressed: () {
                  setState(() {
                    keyNotes = _buttonClick(4);
                  });
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey, textStyle: TextStyle(fontSize: 30)),
              ),
              ElevatedButton(
                  child: new Text("G"),
                  onPressed: () {
                    setState(() {
                      keyNotes = _buttonClick(5);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      textStyle: TextStyle(fontSize: 30))),
              ElevatedButton(
                  child: new Text("A"),
                  onPressed: () {
                    setState(() {
                      keyNotes = _buttonClick(6);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      textStyle: TextStyle(fontSize: 30))),
              ElevatedButton(
                  child: new Text("B"),
                  onPressed: () {
                    setState(() {
                      keyNotes = _buttonClick(7);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.grey, textStyle: TextStyle(fontSize: 30)))
            ],
          ),
          SizedBox(height: 20),
          Text("Guitar Fretboard and Notes", style: TextStyle(fontSize: 25)),
          SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: ScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 240,
                  width: 650,
                  decoration: BoxDecoration(color: Colors.grey),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: frets.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Column(
                            children: [
                              Container(
                                  width: 50,
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: _containerColor(frets, index),
                                      border: Border.all(
                                          color: _borderColor(frets, index))),
                                  child: Text(frets[index],
                                      style: TextStyle(
                                          color: _textColor(frets, index),
                                          fontSize: 20))),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (selectedHighE.contains(index)) {
                                      selectedHighE.remove(index);
                                      print("removed " +
                                          index.toString() +
                                          " from High E String: " +
                                          selectedHighE.toString());
                                    } else {
                                      selectedHighE.add(index);
                                      print("added " +
                                          index.toString() +
                                          " to High E String: " +
                                          selectedHighE.toString());
                                    }
                                    ;
                                    selectedNotes = _getNotes(
                                        ENotes,
                                        selectedE,
                                        ANotes,
                                        selectedA,
                                        DNotes,
                                        selectedD,
                                        GNotes,
                                        selectedG,
                                        BNotes,
                                        selectedB,
                                        hiENotes,
                                        selectedHighE);
                                  });
                                },
                                child: Container(
                                    width: 50,
                                    height: 35,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: keyNotes.isEmpty ? _change(
                                            hiENotes, index, selectedHighE) : _changeWithKey(hiENotes, index, selectedHighE, keyNotes, 6),
                                        border: Border.all(
                                            color:
                                                _borderColor(hiENotes, index))),
                                    child: Text(hiENotes[index],
                                        style: TextStyle(
                                            color: _textColor(hiENotes, index),
                                            fontSize: size))),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (selectedB.contains(index)) {
                                      selectedB.remove(index);
                                      print("removed " +
                                          index.toString() +
                                          " from B String:" +
                                          selectedB.toString());
                                    } else {
                                      selectedB.add(index);
                                      print("added " +
                                          index.toString() +
                                          " to B String: " +
                                          selectedB.toString());
                                    };
                                    selectedNotes = _getNotes(
                                        ENotes,
                                        selectedE,
                                        ANotes,
                                        selectedA,
                                        DNotes,
                                        selectedD,
                                        GNotes,
                                        selectedG,
                                        BNotes,
                                        selectedB,
                                        hiENotes,
                                        selectedHighE);
                                  });
                                },
                                child: Container(
                                    width: 50,
                                    height: 35,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: keyNotes.isEmpty ? _change(BNotes, index, selectedB) : _changeWithKey(BNotes, index, selectedB, keyNotes, 5),
                                        border: Border.all(
                                            color: _borderColor(BNotes, index))),
                                    child: Text(BNotes[index],
                                        style: TextStyle(
                                            color: _textColor(BNotes, index),
                                            fontSize: 20))),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (selectedG.contains(index)) {
                                      selectedG.remove(index);
                                      print("removed " +
                                          index.toString() +
                                          " from G String:" +
                                          selectedG.toString());
                                    } else {
                                      selectedG.add(index);
                                      print("added " +
                                          index.toString() +
                                          " to G String: " +
                                          selectedG.toString());
                                    }
                                    ;
                                    selectedNotes = _getNotes(
                                        ENotes,
                                        selectedE,
                                        ANotes,
                                        selectedA,
                                        DNotes,
                                        selectedD,
                                        GNotes,
                                        selectedG,
                                        BNotes,
                                        selectedB,
                                        hiENotes,
                                        selectedHighE);
                                  });
                                },
                                child: Container(
                                    width: 50,
                                    height: 35,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: keyNotes.isEmpty ? _change(GNotes, index, selectedG) : _changeWithKey(GNotes, index, selectedG, keyNotes, 4),
                                        border: Border.all(
                                            color: _borderColor(GNotes, index))),
                                    child: Text(GNotes[index],
                                        style: TextStyle(
                                            color: _textColor(GNotes, index),
                                            fontSize: 20))),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (selectedD.contains(index)) {
                                      selectedD.remove(index);
                                      print("removed " +
                                          index.toString() +
                                          " from D String:" +
                                          selectedD.toString());
                                    } else {
                                      selectedD.add(index);
                                      print("added " +
                                          index.toString() +
                                          " to D String: " +
                                          selectedD.toString());
                                    }
                                    ;
                                    selectedNotes = _getNotes(
                                        ENotes,
                                        selectedE,
                                        ANotes,
                                        selectedA,
                                        DNotes,
                                        selectedD,
                                        GNotes,
                                        selectedG,
                                        BNotes,
                                        selectedB,
                                        hiENotes,
                                        selectedHighE);
                                  });
                                },
                                child: Container(
                                    width: 50,
                                    height: 35,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: keyNotes.isEmpty ? _change(DNotes, index, selectedD) : _changeWithKey(DNotes, index, selectedG, keyNotes, 3),
                                        border: Border.all(
                                            color: _borderColor(DNotes, index))),
                                    child: Text(DNotes[index],
                                        style: TextStyle(
                                            color: _textColor(DNotes, index),
                                            fontSize: 20))),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (selectedA.contains(index)) {
                                      selectedA.remove(index);
                                      print("removed " +
                                          index.toString() +
                                          " from A String:" +
                                          selectedA.toString());
                                    } else {
                                      selectedA.add(index);
                                      print("added " +
                                          index.toString() +
                                          " to A String: " +
                                          selectedA.toString());
                                    }
                                    ;
                                    selectedNotes = _getNotes(
                                        ENotes,
                                        selectedE,
                                        ANotes,
                                        selectedA,
                                        DNotes,
                                        selectedD,
                                        GNotes,
                                        selectedG,
                                        BNotes,
                                        selectedB,
                                        hiENotes,
                                        selectedHighE);
                                  });
                                },
                                child: Container(
                                    width: 50,
                                    height: 35,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: keyNotes.isEmpty ? _change(ANotes, index, selectedA) : _changeWithKey(ANotes, index, selectedA, keyNotes, 2),
                                        border: Border.all(
                                            color: _borderColor(ANotes, index))),
                                    child: Text(ANotes[index],
                                        style: TextStyle(
                                            color: _textColor(ANotes, index),
                                            fontSize: 20))),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (selectedE.contains(index)) {
                                      selectedE.remove(index);
                                      print("removed " +
                                          index.toString() +
                                          " from Low E String:" +
                                          selectedE.toString());
                                    } else {
                                      selectedE.add(index);
                                      print("added " +
                                          index.toString() +
                                          " to Low E String: " +
                                          selectedE.toString());
                                    }
                                    ;
                                    selectedNotes = _getNotes(
                                        ENotes,
                                        selectedE,
                                        ANotes,
                                        selectedA,
                                        DNotes,
                                        selectedD,
                                        GNotes,
                                        selectedG,
                                        BNotes,
                                        selectedB,
                                        hiENotes,
                                        selectedHighE);
                                  });
                                },
                                child: Container(
                                    width: 50,
                                    height: 35,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: keyNotes.isEmpty ? _change(ENotes, index, selectedE) : _changeWithKey(ENotes, index, selectedE, keyNotes, 1),
                                        border: Border.all(
                                            color: _borderColor(ENotes, index))),
                                    child: Text(ENotes[index],
                                        style: TextStyle(
                                            color: _textColor(ENotes, index),
                                            fontSize: 20))),
                              ),
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text("Selected: ")],
          )
        ],
      ),
    );
  }

  List<String> _getNotes(
      List<String> ENotes,
      List<int> selectedE,
      List<String> ANotes,
      List<int> selectedA,
      List<String> DNotes,
      List<int> selectedD,
      List<String> GNotes,
      List<int> selectedG,
      List<String> BNotes,
      List<int> selectedB,
      List<String> hiENotes,
      List<int> selectedHiE) {
    List<String> notes = [];

    _mapNote(selectedE, ENotes, notes);
    _mapNote(selectedA, ANotes, notes);
    _mapNote(selectedD, DNotes, notes);
    _mapNote(selectedG, GNotes, notes);
    _mapNote(selectedB, BNotes, notes);
    _mapNote(selectedHiE, hiENotes, notes);



    print("notes added " + notes.toString());

    return notes;
  }

  _mapNote(List<int> selected, List<String> notes, List<String> _notes) {

    String string = "";

    switch(notes[0]){
      case "e":{
        string = "e";
        break;
      }
      case "B":{
        string = "B";
        break;
      }
      case "G":{
        string = "G";
        break;
      }
      case "D":{
        string = "D";
        break;
      }
      case "A":{
        string = "A";
        break;
      }
      case "E":{
        string = "E";
        break;
      }
      default: {
        string = "Bruh How";
      }
      break;
    }

    selected.forEach((element) {
      _notes.add(string + element.toString());
    });
    return _notes;
  }

  _buttonClick(int id){

      List<String> key = [];

      switch(id){
        case 1: {
          key = ["E1", "E3", "E5", "E7", "E8", "E10", "E12",
                 "A2", "A3", "A5", "A7", "A8", "A10", "A12",
                 "D2", "D3", "D5", "D7", "D9", "D10", "D12",
                 "G2", "G4", "G5", "G7", "G9", "G10", "G12",
                 "B1", "B3", "B5", "B6", "B8", "B10", "B12",
                 "e1", "e3", "e5", "e7", "e8", "e10", "e12"];
          break;
        }
        case 2: {
          key = ["E2", "E3", "E5", "E7", "E9", "E10", "E12",
                 "A2", "A4", "A5", "A7", "A9", "A10", "A12",
                 "D2", "D4", "D5", "D7", "D9", "D11", "D12",
                 "G2", "G4", "G6", "G7", "G9", "G11", "G12",
                 "B2", "B3", "B5", "B7", "B8", "B10", "B12",
                 "e3", "e5", "e7", "e9", "e10", "e12", "e2"];
          break;
        }
        case 3: {
          key = ["E2", "E4", "E5", "E7", "E9", "E11", "E12",
                 "A2", "A4", "A6", "A7", "A9", "A11", "A12",
                 "D1", "D2", "D4", "D6", "D7", "D9", "D11",
                 "G1", "G2", "G4", "G6", "G8", "G9", "G11",
                 "B2", "B4", "B5", "B7", "B9", "B10", "B12",
                 "e2", "e4", "e5", "e7", "e9", "e11", "e12"];
          break;
        }
        case 4: {
          key = ["E1", "E3", "E5", "E6", "E8", "E10", "E12",
                 "A1", "A3", "A5", "A7", "A8", "A10", "A12",
                 "D2", "D3", "D5", "D7", "D8", "D10", "D12",
                 "G2", "G3", "G5", "G7", "G9", "G10", "G12",
                 "B1", "B3", "B5", "B6", "B8", "B10", "B11",
                 "e1", "e3", "e5", "e6", "e8", "e10", "e12"];
          break;
        }
        case 5: {
          key = ["E2", "E3", "E5", "E7", "E8", "E10", "E12",
                 "A2", "A3", "A5", "A7", "A9", "A10", "A12",
                 "D2", "D4", "D5", "D7", "D9", "D10", "D12",
                 "G2", "G4", "G5", "G7", "G9", "G11", "G12",
                 "B1", "B3", "B5", "B7", "B8", "B10", "B12",
                 "e2", "e3", "e5", "e7", "e8", "e10", "e12"];
          break;
        }
        case 6: {
          key = ["E2", "E4", "E5", "E7", "E9", "E10", "E12",
                 "A2", "A4", "A5", "A7", "A9", "A11", "A12",
                 "D2", "D4", "D6", "D7", "D9", "D11", "D12",
                 "G1", "G2", "G4", "G6", "G7", "G9", "G11",
                 "B2", "B3", "B5", "B7", "B9", "B10", "B12",
                 "e2", "e4", "e5", "e7", "e9", "e10", "e12"];
          break;
        }
        case 7: {
          key = ["E2", "E4", "E6", "E7", "E9", "E11", "E12",
                 "A1", "A2", "A4", "A6", "A7", "A9", "A11",
                 "D1", "D2", "D4", "D6", "D8", "D9", "D11",
                 "G1", "G3", "G4", "G6", "G8", "G9", "G11",
                 "B2", "B4", "B5", "B7", "B9", "B11", "B12",
                 "e2", "e4", "e6", "e7", "e9", "e11", "e12"];
          break;
        }

        // case 2: {}
        // case 3: {}
        // case 4: {}
        // case 5: {}
        // case 6: {}
        // case 7: {}
        // case 8: {}
      }
      print(key);
      return key;
    }
}
