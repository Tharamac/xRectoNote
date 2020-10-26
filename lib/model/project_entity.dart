import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:x_rectonote/model/note_sequence.dart';
import '../config/colors_theme.dart';

class SongProject {
  final int id;
  String songName;
  final Color color;
  List<NoteSequence> noteEvents;
  String note = "";
  int trackDuration;
  SongProject({this.id, this.songName, this.color});

  String lyricsToString() {
    String lyrics = "";
    noteEvents.forEach((element) {
      lyrics += element.lyricWord + " ";
    });
    return lyrics;
  }

  Map toJson() => {
        'id': id,
        'name': songName,
        'color': color.value,
        'track_duration': trackDuration,
        'note': note,
        'noteEvents': jsonEncode(noteEvents)
      };

  factory SongProject.fromJson(dynamic json) {
    var decode = jsonDecode(json['noteEvents']) as List;
    List<NoteSequence> import =
        decode.map((e) => NoteSequence.fromJson(e)).toList();
    return SongProject(
        id: json['id'] as int,
        songName: json['name'] as String,
        color: Color(json['color']))
      ..note = json['note']
      ..trackDuration = json['track_duration']
      ..noteEvents = List.of(import);
  }
}
