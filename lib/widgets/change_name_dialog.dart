import 'package:flutter/material.dart';
import 'package:x_rectonote/config/colors_theme.dart';

class ChangeNameDialog extends StatefulWidget {
  final String pastName;
  ChangeNameDialog(this.pastName);
  @override
  _ChangeNameDialogState createState() => _ChangeNameDialogState();
}

class _ChangeNameDialogState extends State<ChangeNameDialog> {
  final _controller = TextEditingController();

  bool _validate = false;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.pastName;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      width: 330,
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 200,
              child: TextField(
                  maxLines: 1,
                  maxLength: 16,
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Enter your song name",
                    hintStyle: TextStyle(color: Color(0x88FFFFFF)),
                    counterStyle: TextStyle(color: Color(0x88FFFFFF)),
                    errorText: _validate ? "Value cannot be empty." : null,
                  ),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 1.2))),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Flexible(
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pop(context, "CANCEL"),
            ),
          ),
          Flexible(
              child: IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              setState(() {
                _controller.text.isEmpty ? _validate = true : _validate = false;
              });
              if (_validate == false)
                Navigator.pop(context, "OK${_controller.text}");
            },
          )),
        ],
      ),
    ));
  }
}
