import 'package:flutter/cupertino.dart';

class PianoRollGrid extends StatelessWidget {
  final int octaveSize;
  int tableRowNum;
  PianoRollGrid(this.octaveSize){
    tableRowNum = octaveSize * 12;
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Stack(
        children: [
          Table(border: TableBorder.all(width: 0.35),
            defaultColumnWidth: FixedColumnWidth(25),
            children: List<TableRow>.filled(tableRowNum, TableRow(
              children: List<Container>.filled(20, Container(
                height: 24,
                
              ))
            ))
          ),
        ],
      ),
    );
  }
}