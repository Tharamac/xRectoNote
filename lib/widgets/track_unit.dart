import 'package:dart_midi/dart_midi.dart';
import 'package:flutter/material.dart';
import 'package:x_rectonote/config/colors_theme.dart';

class MidiEventView extends StatefulWidget {
  int noteNumber;
  final int duration; // 1 duratrion = sixteenth note
  final int startPosition;
  final double gridHeight;
  final double gridWidth;

  final String lyric; // unit in duration
  final int octaveSize;
  MidiEventView(this.octaveSize, this.gridHeight, this.gridWidth,
      {int midiNoteNumber,
      this.duration,
      this.startPosition,
      this.lyric = ""}) {
    noteNumber = (octaveSize * 12 - 1) - (midiNoteNumber - 12);
  }
  @override
  _MidiEventViewState createState() => _MidiEventViewState();
}

class _MidiEventViewState extends State<MidiEventView> {
  String strLyrics;
  @override
  void initState() {
    strLyrics = widget.lyric;
  }

  void changeLyric(String strChange) {
    setState(() {
      strLyrics = strChange;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.all(widget.noteNumber * widget.gridHeight)),
          Row(
            children: [
              Padding(
                  padding:
                      EdgeInsets.all(widget.startPosition * widget.gridWidth)),
              GestureDetector(
                onTap: () => AlertDialog(),
                child: Container(
                  height: widget.gridHeight,
                  width: widget.gridWidth * widget.duration + 1,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: RectoNoteColors.colorPrimary,
                      border: Border.all(
                          color: RectoNoteColors.colorAccent, width: 2)),
                  child: Text(strLyrics, style: TextStyle(color: Colors.black)),
                ),
              )
            ],
          )
        ]);
  }
}

class NoteEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
