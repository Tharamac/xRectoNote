import 'dart:math';
import 'package:flutter/material.dart';
import 'config/colors_theme.dart';


class SongProject {
  final int id;
  final String songName;
  final Color color = RectoNoteColors.projectColors[Random().nextInt(RectoNoteColors.projectColors.length)];
  String lyrics = "";
  String note = "";
  SongProject({this.id, this.songName});
}
