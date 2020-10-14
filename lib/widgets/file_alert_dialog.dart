import 'package:flutter/material.dart';
import 'package:x_rectonote/config/colors_theme.dart';

class ShowFileAlertDialog extends StatefulWidget {
  final String fileName;

  ShowFileAlertDialog(this.fileName);
  @override
  _ShowFileAlertDialogState createState() => _ShowFileAlertDialogState();
}

class _ShowFileAlertDialogState extends State<ShowFileAlertDialog> {
  final TextEditingController _controller = TextEditingController();
  bool _validate = false;

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
                    widget.fileName,
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
                hintStyle: TextStyle(color: Color(0x88FFFFFF)),
                errorText: _validate ? "Value cannot be empty." : null,
              ),
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
            onPressed: () {
              setState(() {
                _controller.text.isEmpty ? _validate = true : _validate = false;
              });
              if (_validate == false)
                Navigator.pop(context, "OK${_controller.text}");
            }),
        FlatButton(
          child: Text("CANCEL",
              style: TextStyle(
                color: RectoNoteColors.colorPrimary,
              )),
          onPressed: () => Navigator.pop(context, "CANCEL"),
        )
      ],
    );
  }
}
