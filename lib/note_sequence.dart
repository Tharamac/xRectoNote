class NoteSequence {
  final int midiNoteNumber;
  int duration = 0;
  final int startDuration;
  bool isFinished = false;
  String lyricWord = "";
  NoteSequence({this.midiNoteNumber, this.startDuration});
}
