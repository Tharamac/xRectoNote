import 'dart:math';

import 'package:flutter/material.dart';
import 'package:x_rectonote/config/colors_theme.dart';

class ProjectItemCard extends StatelessWidget {
  final String songName;
  final int projectColorIdx =
      Random().nextInt(RectoNoteColors.projectColors.length);
  ProjectItemCard({this.songName});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: RectoNoteColors.projectColors[projectColorIdx],
      child: Text(
        songName,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      ),
    );
  }
}
