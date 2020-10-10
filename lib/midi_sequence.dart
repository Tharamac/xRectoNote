import 'dart:io';

import 'package:dart_midi/dart_midi.dart';

class MidiSequence {
  final File midiFile;
  final String fileName;
  MidiFile parseMidi;
  MidiSequence({this.fileName, this.midiFile}) {
    var parser = MidiParser();
    parseMidi = parser.parseMidiFromFile(midiFile);
  }
  @override
  String toString() {
    return parseMidi.tracks.toString();
  }
}
