import 'dart:io';

import 'package:dart_midi/dart_midi.dart';

class MidiSequence {
  MidiFile midi;
  final String midiPath;
  List<dynamic> noteSequence;
  int tickPerBeat;

  MidiSequence(this.midiPath) {
    this.midi = MidiParser().parseMidiFromFile(File(midiPath));
    tickPerBeat = midi.header.ticksPerBeat;
    if (midi.header.format == 0) {
      noteSequence = midi.tracks[0];
    } else if (midi.header.format == 1) {
      noteSequence = midi.tracks[1];
    }
    noteSequence.removeAt(0);
  }
  @override
  String toString() {
    return midi.tracks.toString();
  }
}
