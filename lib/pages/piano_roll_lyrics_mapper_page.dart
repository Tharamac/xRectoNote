import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_rectonote/bloc/project_list_cubit.dart';
import 'package:x_rectonote/config/colors_theme.dart';
import 'package:x_rectonote/project_entity.dart';

class PianoRollLyricsMapperParam {
  final param;
  PianoRollLyricsMapperParam(this.param);
}

class PianoRollLyricsMapperPage extends StatefulWidget {
  final param;
  PianoRollLyricsMapperPage(this.param);
  @override
  _PianoRollLyricsMapperPageState createState() =>
      _PianoRollLyricsMapperPageState();
}

class _PianoRollLyricsMapperPageState extends State<PianoRollLyricsMapperPage> {
  bool _isAddNew = true;

  @override
  void initState() {
    super.initState();
    if (widget.param is int) {
      _isAddNew = false;
    } else if (widget.param is String) {
      _isAddNew = true;
    }
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectListCubit, List<SongProject>>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
            title: Text(
              _isAddNew
                  ? widget.param
                  : state[widget.param].songName.replaceAll(".mid", ""),
              style: TextStyle(
                  color: RectoNoteColors.colorPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: null,
                    child: Icon(
                      Icons.done,
                      size: 26.0,
                    ),
                  ))
            ]),
      );
    });
  }
}
