import 'dart:io';

import 'package:dart_midi/dart_midi.dart';

class MidiSequence {
  MidiFile midi;
  final String midiPath;
  List noteSequence;

  MidiSequence(this.midiPath) {
    this.midi = MidiParser().parseMidiFromFile(File(midiPath));

    if (midi.header.format == 0)
      noteSequence = midi.tracks[0];
    else if (midi.header.format == 1) {
      noteSequence = midi.tracks[1];
    }
  }
  @override
  String toString() {
    return midi.tracks.toString();
  }
}
