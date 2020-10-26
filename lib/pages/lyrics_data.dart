import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_rectonote/blocs/project_list_cubit.dart';
import 'package:x_rectonote/config/routes.dart';
import 'package:x_rectonote/model/storage.dart';
import 'package:x_rectonote/pages/piano_roll_lyrics_mapper_page.dart';

import '../config/colors_theme.dart';
import '../model/project_entity.dart';

class LyricsDataParam {
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
  TextEditingController _noteController = TextEditingController();

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
    return BlocBuilder<ProjectListCubit, List<SongProject>>(
        builder: (context, state) {
      _noteController.text = state[widget.selectedDataIdx].note;
      return Scaffold(
          appBar: AppBar(
              title: Text(
                state[widget.selectedDataIdx].songName,
                style: TextStyle(
                    color: RectoNoteColors.colorPrimary, fontSize: 25),
              ),
              actions: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        state[widget.selectedDataIdx].note =
                            _noteController.text;
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.done,
                        size: 26.0,
                      ),
                    ))
              ]),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Lyrics : ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic),
                    ),
                    FlatButton(
                      child: Text("Edit Lyrics",
                          style: TextStyle(
                              color: RectoNoteColors.colorPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.w600)),
                      onPressed: () => Navigator.of(context)
                          .pushNamed(AppRoutes.pianoRollMapperPage,
                              arguments: LyricsMapperEditExistParam(
                                  widget.selectedDataIdx,
                                  state[widget.selectedDataIdx].songName,
                                  state[widget.selectedDataIdx].noteEvents,
                                  trackDuration: state[widget.selectedDataIdx]
                                      .trackDuration))
                          .then((value) {
                        SongProjectStorage().saveSongProjectList(state);
                        print("saved");
                        Navigator.pop(context);
                      }),
                    )
                  ],
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                        color: Colors.black12,
                        padding: EdgeInsets.all(20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(
                                    (state[widget.selectedDataIdx].noteEvents ==
                                            null)
                                        ? "<No Lyrics Here>"
                                        : state[widget.selectedDataIdx]
                                            .lyricsToString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                        height: 1.2),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              )
                            ]))),
                Padding(
                  padding: EdgeInsets.all(15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Note : ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                ),
                Expanded(
                  child: Container(
                      color: Colors.black12,
                      //padding: EdgeInsets.only(left: 20 , right: 20,top : 7),
                      child: TextFormField(
                        controller: _noteController,
                        maxLines: 7,
                        decoration: InputDecoration(
                            hintText: "Write your thought here",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: RectoNoteColors.colorPrimaryDark))),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            height: 1.2),
                      )),
                )
              ],
            ),
          ));
    });
  }
}
