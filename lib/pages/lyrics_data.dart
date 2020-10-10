import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import '../bloc/project_list_cubit.dart';
import '../config/colors_theme.dart';
import '../config/colors_theme.dart';
import '../config/colors_theme.dart';
import '../config/colors_theme.dart';
import '../config/colors_theme.dart';
import '../config/colors_theme.dart';
import '../project_entity.dart';

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
                      onPressed: null,
                    )
                  ],
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.black12,
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Spicy jalapeno bacon ipsum dolor amet pork belly tenderloin meatball venison chicken, jowl ground round cow turducken ham hock andouille. Tail beef ribs shank corned beef kevin, flank swine frankfurter. Pork beef chuck leberkas flank, swine t-bone. Boudin venison sirloin swine capicola pig. Ribeye tenderloin meatball sirloin, sausage jerky rump pork chop chicken ham cupim frankfurter burgdoggen doner jowl.",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            height: 1.2),
                        textAlign: TextAlign.justify,
                      ),
                    )),
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
