import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/project_list_cubit.dart';
import '../config/colors_theme.dart';
import '../config/colors_theme.dart';
import '../project_entity.dart';

class LyricsDataParam{
  final int selectedDataIdx;
  LyricsDataParam(this.selectedDataIdx);
}

class LyricsDataPage extends StatefulWidget {
  final int selectedDataIdx;
  LyricsDataPage(this.selectedDataIdx);
  @override
  _LyricsDataPageState createState() => _LyricsDataPageState();
}

class _LyricsDataPageState extends State<LyricsDataPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectListCubit, List<SongProject>>(
      builder: (context, state){
        return Scaffold(
          appBar: AppBar(
            title: Text(state[widget.selectedDataIdx].songName,
              style: TextStyle(color: RectoNoteColors.colorPrimary, fontSize: 25),
              ),
          ),
          body: Column(children: [
            
          ],),
        );
      }
    );
  }
}
