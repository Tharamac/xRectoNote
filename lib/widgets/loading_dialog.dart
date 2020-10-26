import 'package:flutter/material.dart';
import 'package:x_rectonote/config/colors_theme.dart';

class LoadingDialog {
  final String loadingMessage;
  LoadingDialog(this.loadingMessage);
  Future<void> showLoadingDialog(BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Row(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          loadingMessage,
                          style: TextStyle(color: RectoNoteColors.colorPrimary),
                        )
                      ]),
                    )
                  ]));
        });
  }
}
