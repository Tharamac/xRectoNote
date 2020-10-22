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
  final int id;

  final String lyric; // unit in duration

  MidiNoteEventView(this.id, this.gridHeight, this.gridWidth,
      {this.duration, this.lyric = ""});
  @override
  _MidiNoteEventViewState createState() => _MidiNoteEventViewState();
}

class _MidiNoteEventViewState extends State<MidiNoteEventView> {
  String strLyrics;
  GlobalKey _key = GlobalKey();
  bool isClicked = false;
  final _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    strLyrics = widget.lyric;
    _controller.text = strLyrics;
  }

  Offset _getPositions() {
    final RenderBox renderBoxRed = _key.currentContext.findRenderObject();
    final position = renderBoxRed.localToGlobal(Offset.zero);
    return position;
  }

  void changeLyric(String strChange) {
    setState(() {
      strLyrics = strChange;
    });
  }

  void clickingColor() {
    setState(() {
      isClicked = true;
    });
  }

  void idleColor() {
    setState(() {
      isClicked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        clickingColor();
        var offset = _getPositions();

        var appWidth = MediaQuery.of(context).size.width;
        var appHeight = MediaQuery.of(context).size.height;
        print("$offset   ${offset.dy / appHeight}");
        String response = await showDialog<String>(
            context: context,
            barrierDismissible: true,
            barrierColor: Color(0x33FFFFFF),
            builder: (BuildContext context) {
              return Align(
                  alignment: Alignment.topCenter,
                  child: SpeechBubble(
                    color: Colors.black,
                    child: Container(
                      height: 40,
                      width: 170,
                      padding: EdgeInsets.only(left: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 120,
                              child: TextField(
                                  maxLines: 1,
                                  maxLength: 8,
                                  controller: _controller,
                                  decoration: InputDecoration(
                                      counterStyle: TextStyle(
                                          fontSize: 10, color: Colors.white)))),
                          Flexible(
                              child: FlatButton(
                            child: Icon(
                              Icons.done,
                              color: RectoNoteColors.colorPrimary,
                            ),
                            onPressed: () {
                              setState(() {
                                strLyrics = _controller.text;
                              });
                              Navigator.pop(context);
                            },
                          ))
                        ],
                      ),
                    ),
                  ));
              //SpeechBubble(
              //     color: Colors.black,
              //     child:
              //     ));
            });
        idleColor();
      },
      child: Container(
        key: _key,
        height: widget.gridHeight,
        width: widget.gridWidth * widget.duration / 2 + 1,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: (isClicked)
                ? RectoNoteColors.highlightedPrimary
                : RectoNoteColors.colorPrimary,
            border: Border.all(
                color: (isClicked)
                    ? RectoNoteColors.highlightedBorder
                    : RectoNoteColors.colorAccent,
                width: 2)),
        child: Text(strLyrics, style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
