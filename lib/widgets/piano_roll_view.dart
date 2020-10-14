import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PianoRollGrid extends StatelessWidget {
  final int octaveSize;
  int tableRowNum;
  PianoRollGrid(this.octaveSize){
    this.tableRowNum = octaveSize * 12;
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Stack(
        children: [
          Table(border: TableBorder.all(width: 0.35),
            defaultColumnWidth: FixedColumnWidth(25),
            children: List<TableRow>.generate(tableRowNum,(i) => 
            (i % 12 == 0) ? 
              TableRow(
                children: List<Container>.generate(64, (i) => Container(
                  height: 24,
                  child:  Text(( i % 8 == 0) ?  "| ${i ~/8}->\n|" : "" , style: TextStyle(fontSize: 11, height: 0.1),),
                ))
              )
              :
              TableRow(
                children: List<Container>.generate(64, (i) => Container(
                  height: 24,
                  child: Text(( i % 8 == 0) ?  "|\n|" : ""  , style: TextStyle(fontSize: 11, textBaseline: TextBaseline.ideographic),),
                ))
              ) 
            ),

          )
          
        ],
      ),
    );
  }
}