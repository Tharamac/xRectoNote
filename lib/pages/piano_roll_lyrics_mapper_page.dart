import 'dart:io';

import 'package:dart_midi/dart_midi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_rectonote/blocs/lyrics_cubit.dart';
import 'package:x_rectonote/blocs/project_list_cubit.dart';
import 'package:x_rectonote/config/colors_theme.dart';
import 'package:x_rectonote/midi_sequence.dart';
import 'package:x_rectonote/note_sequence.dart';
import 'package:x_rectonote/project_entity.dart';
import 'package:x_rectonote/widgets/piano_roll_view.dart';
import 'package:x_rectonote/widgets/piano_view.dart';
import 'package:x_rectonote/widgets/midi_note_event.dart';

class PianoRollLyricsMapperParam {
  final String songName;
  final String midiPath;
  PianoRollLyricsMapperParam(this.songName, this.midiPath);
}

class PianoRollLyricsMapperPage extends StatefulWidget {
  final param;
  final String midiPath;
  bool isAddNew;
  List<NoteSequence> midi;
  MidiSequence midiSequence;
  final int octaveSize = 9;
  final double gridHeight = 24;
  final double gridWidth = 50;
  PianoRollLyricsMapperPage(this.param, [this.midiPath]) {
    isAddNew = false;
  }
  PianoRollLyricsMapperPage.addNew(this.param, this.midiPath) {
    isAddNew = true;
    midiSequence = MidiSequence(midiPath);
    midi = midiSequence.decodeMidiEvent();
  }

  @override
  _PianoRollLyricsMapperPageState createState() =>
      _PianoRollLyricsMapperPageState();
}

class _PianoRollLyricsMapperPageState extends State<PianoRollLyricsMapperPage> {
  var _pianoRollController;
  @override
  void initState() {
    super.initState();
    _pianoRollController = ScrollController(
        initialScrollOffset: ((widget.octaveSize * 12 - 1) -
                (widget.midi[0].midiNoteNumber - 12)) *
            widget.gridHeight);

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
    context.bloc<NoteSequenceCubit>().initList(widget.midi);
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PianoView(widget.octaveSize),
                      Expanded(
                          flex: 35,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Stack(
                                  children: <Widget>[
                                PianoRollGrid(
                                    widget.octaveSize,
                                    widget.gridHeight,
                                    widget.gridWidth,
                                    widget.midiSequence.trackDuration * 8),
                              ]
                                      .followedBy(context
                                          .bloc<NoteSequenceCubit>()
                                          .state
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        int idx = entry.key;
                                        var e = entry.value;
                                        int noteNumber =
                                            (widget.octaveSize * 12 - 1) -
                                                (e.midiNoteNumber - 12);
                                        return Positioned(
                                          top: noteNumber * widget.gridHeight,
                                          left: e.startDuration *
                                              widget.gridWidth /
                                              2,
                                          child: MidiNoteEventView(
                                            idx,
                                            widget.gridHeight,
                                            widget.gridWidth,
                                            duration: e.duration,
                                          ),
                                        );
                                      }).toList())
                                      .toList())))
                    ],
                  ))));
    });
  }
}
