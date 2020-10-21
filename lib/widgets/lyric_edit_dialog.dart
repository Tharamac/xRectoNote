import 'package:flutter/material.dart';

class LyricEditDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: [Text("da"),
          FlatButton(
            onPressed: null,
            child: Icon(Icons.done),
          )
        ],
      )
    );
  }
}