import 'dart:io';

import 'package:dart_midi/dart_midi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_rectonote/bloc/project_list_cubit.dart';
import 'package:x_rectonote/config/colors_theme.dart';
import 'package:x_rectonote/midi_sequence.dart';
import 'package:x_rectonote/project_entity.dart';
import 'package:x_rectonote/widgets/piano_roll_view.dart';
import 'package:x_rectonote/widgets/piano_view.dart';

class PianoRollLyricsMapperParam {
  final String songName;
  final String midiPath;
  PianoRollLyricsMapperParam(this.songName, this.midiPath);
}

class PianoRollLyricsMapperPage extends StatefulWidget {
  final param;
  String midiPath;
  bool isAddNew;
  MidiSequence midi;
  PianoRollLyricsMapperPage(this.param) {
    isAddNew = false;
  }
  PianoRollLyricsMapperPage.addNew(this.param, this.midiPath) {
    isAddNew = true;
    midi = MidiSequence(midiPath);
  }
  @override
  _PianoRollLyricsMapperPageState createState() =>
      _PianoRollLyricsMapperPageState();
}

class _PianoRollLyricsMapperPageState extends State<PianoRollLyricsMapperPage> {
  final _pianoRollController = ScrollController(initialScrollOffset: 24.0 * 48.5);
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectListCubit, List<SongProject>>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
            title: Text(
              widget.isAddNew ? widget.param : state[widget.param].songName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: null,
                    child: Icon(
                      Icons.done,
                      size: 26.0,
                    ),
                  ))
            ]),
        body: SafeArea(
            child: SingleChildScrollView(
              controller: _pianoRollController,
              child: Row(
                children: [
                  PianoView(9),
                  Expanded(flex: 35,
                  child: PianoRollGrid(9))
                  
                ],

              ),
            )
              
               
        
        )
      );
    });
  }
}
