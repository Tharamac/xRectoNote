import 'dart:io';

import 'package:dart_midi/dart_midi.dart';
import 'package:x_rectonote/note_sequence.dart';

class MidiSequence {
  MidiFile midi;
  final String midiPath;
  List<dynamic> noteSequence;
  int tickPerBeat;
  int tickPerDuration;
  int trackDuration = 0;

  MidiSequence(this.midiPath) {
    this.midi = MidiParser().parseMidiFromFile(File(midiPath));
    tickPerBeat = midi.header.ticksPerBeat;
    tickPerDuration = tickPerBeat ~/ 4;
    if (midi.header.format == 0) {
      noteSequence = midi.tracks[0];
    } else if (midi.header.format == 1) {
      noteSequence = midi.tracks[1];
    }
    noteSequence.removeAt(0);
  }
  @override
  String toString() {
    return noteSequence.toString();
  }

  List<NoteSequence> decodeMidiEvent() {
    int tickTime = 0; // unit in tick
    int pastDeltaTime = 0;
    var out = List<NoteSequence>();
    noteSequence.forEach((event) {
      if (event is NoteOnEvent && event.velocity != 0) {
        out.add(NoteSequence(
            midiNoteNumber: event.noteNumber,
            startDuration: (tickTime + event.deltaTime) ~/ tickPerDuration));
      } else if (event is NoteOffEvent) {
        var whereNoteOn = out.firstWhere((e) =>
            e.isFinished == false && e.midiNoteNumber == event.noteNumber);
        if (event.deltaTime == 0) {
          whereNoteOn.duration = pastDeltaTime;
        } else {
          whereNoteOn.duration = event.deltaTime ~/ tickPerDuration;
        }
        whereNoteOn.isFinished = true;
        pastDeltaTime = event.deltaTime;
        tickTime += event.deltaTime;
      }
    });
    trackDuration = tickTime ~/ tickPerDuration;
    return out;
  }
}
