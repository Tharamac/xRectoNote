import 'dart:io';
import 'dart:math';

import 'package:dart_midi/dart_midi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:x_rectonote/blocs/lyrics_cubit.dart';
import 'package:x_rectonote/blocs/project_list_cubit.dart';
import 'package:x_rectonote/config/colors_theme.dart';
import 'package:x_rectonote/model/midi_sequence.dart';
import 'package:x_rectonote/model/note_sequence.dart';
import 'package:x_rectonote/model/project_entity.dart';
import 'package:x_rectonote/widgets/change_name_dialog.dart';
import 'package:x_rectonote/widgets/loading_dialog.dart';
import 'package:x_rectonote/widgets/piano_roll_view.dart';
import 'package:x_rectonote/widgets/piano_view.dart';
import 'package:x_rectonote/widgets/midi_note_event.dart';

class LyricsMapperAddNewParam {
  final String songName;
  final String midiPath;
  LyricsMapperAddNewParam(this.songName, this.midiPath);
}

class LyricsMapperEditExistParam {
  final int idx;
  final String songName;
  final List<NoteSequence> midi;
  final int trackDuration;
  LyricsMapperEditExistParam(this.idx, this.songName, this.midi,
      {this.trackDuration = 4});
}

class PianoRollLyricsMapperPage extends StatefulWidget {
  int idx;
  String midiPath;
  bool isAddNew;
  List<NoteSequence> midi;
  final songName;
  MidiSequence midiSequence;
  int trackDuration;
  final int octaveSize = 9;
  final double gridHeight = 24;
  final double gridWidth = 50;
  PianoRollLyricsMapperPage(
      this.idx, this.songName, this.midi, this.trackDuration) {
    isAddNew = false;
  }
  PianoRollLyricsMapperPage.addNew(this.songName, this.midiPath) {
    isAddNew = true;
    midiSequence = MidiSequence(midiPath);
    midi = midiSequence.decodeMidiEvent();
    trackDuration = midiSequence.trackDuration;
  }

  @override
  _PianoRollLyricsMapperPageState createState() =>
      _PianoRollLyricsMapperPageState();
}

class _PianoRollLyricsMapperPageState extends State<PianoRollLyricsMapperPage> {
  var _pianoRollController;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  String songName;
  @override
  void initState() {
    super.initState();
    _pianoRollController = ScrollController(
        initialScrollOffset: ((widget.octaveSize * 12 - 1) -
                (widget.midi[0].midiNoteNumber - 12)) *
            widget.gridHeight);
    songName = widget.songName;

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

  Future<void> afterLoad() async {}
  @override
  Widget build(BuildContext context) {
    context.bloc<NoteSequenceCubit>().initList(widget.midi);
    return BlocBuilder<ProjectListCubit, List<SongProject>>(
        builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
              title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  songName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    String response = await showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) =>
                          ChangeNameDialog(songName),
                    );
                    if (response != "CANCEL") {
                      response = response.replaceFirst("OK", "");
                      setState(() {
                        songName = response;
                      });
                    }
                  },
                )
              ]),
              actions: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: IconButton(
                      onPressed: () {
                        if (widget.isAddNew) {
                          var newOne = SongProject(
                              id: state.length,
                              songName: songName,
                              color: RectoNoteColors.projectColors[Random()
                                  .nextInt(
                                      RectoNoteColors.projectColors.length)]);
                          newOne.trackDuration =
                              widget.midiSequence.trackDuration;
                          newOne.noteEvents =
                              List.of(context.bloc<NoteSequenceCubit>().state);
                          context
                              .bloc<ProjectListCubit>()
                              .newSongProject(newOne);
                        } else {
                          state[widget.idx].noteEvents =
                              List.of(context.bloc<NoteSequenceCubit>().state);
                          state[widget.idx].songName = songName;
                        }
                        Navigator.pop(context);
                      },
                      icon: Icon(
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
                                    widget.trackDuration * 8),
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
