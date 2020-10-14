import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PianoView extends StatelessWidget {
  final int octaveSize;
  List<String> pianoList;
  PianoView(this.octaveSize){
    pianoList = List<String>.generate(octaveSize * 12, (i){
      String temp; 
      switch(i % 12){
        case 0: temp = "C"; break;
        case 1: temp = "C#";break;
        case 2: temp = "D";break;
        case 3: temp = "D#";break;
        case 4: temp = "E";break;
        case 5: temp = "F";break;
        case 6: temp = "F#";break;
        case 7: temp = "G";break;
        case 8: temp = "G#";break;
        case 9: temp = "A";break;
        case 10: temp = "A#";break;
        case 11: temp = "B";break;
      }
      return temp + "${i ~/ 12}";
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(children:  pianoList.reversed.map<Widget>( (note) =>
          Container(
            width: 60,
            height: 24,
            decoration: BoxDecoration(
               color: (note.contains("#")) ? Colors.black : Colors.white,
               border: Border(top: BorderSide(width: 0.35))
            ),
           
            padding: EdgeInsets.all(5),
            child: Text(note, style: TextStyle(color: (note.contains("#")) ? Colors.white : Colors.black),),
          )
      ).toList(),
     
        
      
    );
  }
}
