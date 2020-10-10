import 'package:flutter/material.dart';
import 'package:x_rectonote/config/colors_theme.dart';

class ShowFileAlertDialog extends StatelessWidget {
  final String fileName;
  final TextEditingController _controller = TextEditingController();
  ShowFileAlertDialog(this.fileName);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Lyrics to"),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: RectoNoteColors.colorPrimary,
                border:
                    Border.all(color: RectoNoteColors.colorAccent, width: 3)),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.description,
                  color: Colors.black,
                ),
                Expanded(
                  child: Text(
                    fileName,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                )
              ],
            ),
          ),
          TextField(
              maxLines: 1,
              maxLength: 16,
              controller: _controller,
              decoration: InputDecoration(
                  hintText: "Enter your song name",
                  hintStyle: TextStyle(color: Color(0x88FFFFFF))),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  height: 1.2)),
        ],
      ),
      actions: [
        FlatButton(
          child: Text("OK",
              style: TextStyle(
                color: RectoNoteColors.colorPrimary,
              )),
          onPressed: () => Navigator.pop(context, "OK"),
        ),
        FlatButton(
          child: Text("CANCEL",
              style: TextStyle(
                color: RectoNoteColors.colorPrimary,
              )),
          onPressed: () => Navigator.pop(context, "Cancel"),
        )
      ],
    );
  }
}
