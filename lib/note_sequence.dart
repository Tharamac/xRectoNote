class NoteSequence {
  final int midiNoteNumber;
  int duration = 0;
  final int startDuration;
  bool isFinished = false;
  NoteSequence({this.midiNoteNumber, this.startDuration});
}
