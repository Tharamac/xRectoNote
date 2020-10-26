class NoteSequence {
  final int midiNoteNumber;
  int duration = 0;
  final int startDuration;
  bool isFinished = false;
  String lyricWord = "";
  NoteSequence({this.midiNoteNumber, this.startDuration});

  @override
  String toString() {
    return "[note : $midiNoteNumber, duration : $duration, lyricWord: $lyricWord]\n";
  }

  Map toJson() => {
        'midiNoteNumber': midiNoteNumber,
        'duration': duration,
        'start_duration': startDuration,
        'is_finished': isFinished,
        'lyric_word': lyricWord,
      };

  factory NoteSequence.fromJson(dynamic json) {
    return NoteSequence(
        midiNoteNumber: json['midiNoteNumber'] as int,
        startDuration: json['start_duration'] as int)
      ..duration = json['duration']
      ..isFinished = json['is_finished']
      ..lyricWord = json['lyric_word'];
  }
}
