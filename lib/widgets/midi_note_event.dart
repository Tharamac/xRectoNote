import 'package:bubble/bubble.dart';
import 'package:dart_midi/dart_midi.dart';
import 'package:flutter/material.dart';
import 'package:x_rectonote/config/colors_theme.dart';

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
  final _controller = TextEditingController();
  @override
  void initState() {
    strLyrics = widget.lyric;
    _controller.text = strLyrics;
  }

  void changeLyric(String strChange) {
    setState(() {
      strLyrics = strChange;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: null,
      child: Container(
        height: widget.gridHeight,
        width: widget.gridWidth * widget.duration / 2 + 1,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: RectoNoteColors.colorPrimary,
            border: Border.all(color: RectoNoteColors.colorAccent, width: 2)),
        child: Text(strLyrics, style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
