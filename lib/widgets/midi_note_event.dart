import 'package:bubble/bubble.dart';
import 'package:dart_midi/dart_midi.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:speech_bubble/speech_bubble.dart';
import 'package:x_rectonote/config/colors_theme.dart';
import 'package:x_rectonote/widgets/lyric_edit_dialog.dart';

class MidiNoteEventView extends StatefulWidget {
  final int duration; // 1 duratrion = sixteenth note
  final double gridHeight;
  final double gridWidth;

  final String lyric; // unit in duration

  MidiNoteEventView(this.gridHeight, this.gridWidth,
      {this.duration, this.lyric = ""});
  @override
  _MidiNoteEventViewState createState() => _MidiNoteEventViewState();
}

class _MidiNoteEventViewState extends State<MidiNoteEventView> {
  String strLyrics;
  bool isClicked = false;
  final _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
   
    strLyrics = widget.lyric;
    _controller.text = strLyrics;
  }

  void changeLyric(String strChange) {
    setState(() {
      strLyrics = strChange;
    });
  }
  void clickingColor(){
    setState(() {
      isClicked = true;
    });
  }
  void idleColor(){
    setState(() {
      isClicked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        clickingColor();
        String response = await showDialog<String>(
          context: context,
          barrierDismissible: true,
          barrierColor: Colors.transparent,
          builder: (BuildContext context){
            return AlertDialog(
              content: Text("dd"),
            );
          }
        
         
        );
      idleColor();
      if(response == "change"){
        strLyrics = _controller.text;
      }
          
        

      },
      child: Container(   
        height: widget.gridHeight,
        width: widget.gridWidth * widget.duration / 2 + 1,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: (isClicked)? RectoNoteColors.highlightedPrimary : RectoNoteColors.colorPrimary,
            border: Border.all(color: (isClicked)? RectoNoteColors.highlightedBorder : RectoNoteColors.colorAccent, width: 2)),
        child: Text(strLyrics, style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
