import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:x_rectonote/bloc/project_list_cubit.dart';
import 'package:x_rectonote/config/colors_theme.dart';
import 'package:x_rectonote/project_entity.dart';
import 'package:x_rectonote/widgets/project_item.dart';

import '../config/colors_theme.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
          separatorBuilder:  (BuildContext context, int index) {
                          return SizedBox(height: 10);
                          },
        );
      })),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.event_add,
        children: [
          SpeedDialChild(
            child: Icon(Icons.queue_music),
            label: "Create lyrics from MIDI",
            labelStyle: TextStyle(color: Colors.black),
            backgroundColor: RectoNoteColors.speedDialBackgorund,
            onTap: () async{
            FilePickerResult result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['mid']
            );
            if(result != null) {
              PlatformFile file = result.files.first;
    
                print(file.name);
                print(file.bytes);
                print(file.size);
                print(file.extension);
                print(file.path);
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
