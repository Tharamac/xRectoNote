import 'dart:math';

import 'package:flutter/material.dart';
import 'package:x_rectonote/config/colors_theme.dart';

import '../config/routes.dart';
import '../pages/lyrics_data.dart';

class ProjectItemCard extends StatelessWidget {
  final int id;
  final String songName;
  final Color displayColor;
  ProjectItemCard({this.id ,this.songName, this.displayColor});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(color: displayColor,borderRadius: BorderRadius.all(Radius.circular(7.0))),
        
        child: Text(
          songName,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
        ),
      ),
      onTap: () => Navigator.pushNamed(context, AppRoutes.lyricsDataPage, arguments: LyricsDataParam(id)),
    );
  }
}
