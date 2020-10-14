import 'dart:io';

import 'package:animate_icons/animate_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:x_rectonote/bloc/project_list_cubit.dart';
import 'package:x_rectonote/config/colors_theme.dart';
import 'package:x_rectonote/config/routes.dart';
import 'package:x_rectonote/pages/piano_roll_lyrics_mapper_page.dart';
import 'package:x_rectonote/project_entity.dart';
import 'package:x_rectonote/widgets/file_alert_dialog.dart';
import 'package:x_rectonote/widgets/project_item.dart';

import '../config/colors_theme.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
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
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "xRectoNote",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: RectoNoteColors.colorPrimary,
                fontSize: 32,
                fontWeight: FontWeight.w700),
          ),
          backgroundColor: RectoNoteColors.appBarColor,
        ),
        body: Center(child: BlocBuilder<ProjectListCubit, List<SongProject>>(
            builder: (context, state) {
          return ListView.separated(
            scrollDirection: Axis.vertical,
            itemCount: state.length,
            padding: EdgeInsets.all(10),
            itemBuilder: (BuildContext context, int i) {
              return ProjectItemCard(
                id: state[i].id,
                songName: state[i].songName,
                displayColor: state[i].color,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 10);
            },
          );
        })),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
              child: Icon(Icons.queue_music),
              label: "Create lyrics from MIDI",
              labelStyle: TextStyle(color: Colors.black),
              backgroundColor: RectoNoteColors.speedDialBackgorund,
              onTap: () async {
                FilePickerResult result = await FilePicker.platform.pickFiles(
                    type: FileType.custom, allowedExtensions: ['mid']);
                if (result != null) {
                  PlatformFile file = result.files.first;
                  String response = await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) =>
                          ShowFileAlertDialog(file.name));
                  print(response);
                  if (response != "CANCEL") {
                    Navigator.of(context).pushNamed(
                        AppRoutes.pianoRollMapperPage,
                        arguments: PianoRollLyricsMapperParam(
                            response.replaceFirst("OK", ""),
                            result.files.single.path));
                  }
                }
              },
            )
          ],
        )

        // FloatingActionButton(
        //   onPressed:
        //   tooltip: 'Increment',
        //   child: Icon(Icons.add),
        // ),
        );
  }
}
