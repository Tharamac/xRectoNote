import 'package:flutter/cupertino.dart';

class PianoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 1,
    );
  }
}
