import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PianoRollGrid extends StatelessWidget {
  final int octaveSize;
  final double gridHeight;
  final double gridWidth;
  final int gridDuration;
  int tableRowNum;
  PianoRollGrid(
    this.octaveSize,
    this.gridHeight,
    this.gridWidth,
    this.gridDuration,
  ) {
    this.tableRowNum = octaveSize * 12;
  }

  @override
  Widget build(BuildContext context) {
    return Table(
        border: TableBorder.all(width: 0.35, color: Color(0xFF000000)),
        defaultColumnWidth: FixedColumnWidth(gridWidth),
        children: List<TableRow>.generate(
            tableRowNum,
            (i) => (i % 12 == 0)
                ? TableRow(
                    children: List<Container>.generate(
                        gridDuration,
                        (i) => Container(
                              height: gridHeight,
                              child: Text(
                                (i % 8 == 0) ? "| ${i ~/ 8}\n|\n|" : "",
                                style: TextStyle(
                                    fontSize: 12,
                                    height: 0.5,
                                    color: Color(0xFF777777)),
                              ),
                            )))
                : TableRow(
                    children: List<Container>.generate(
                        gridDuration,
                        (i) => Container(
                              height: gridHeight,
                              child: Text(
                                (i % 8 == 0) ? "|\n|" : "",
                                style: TextStyle(
                                    fontSize: 11,
                                    height: 0.8,
                                    color: Color(0xFF777777),
                                    textBaseline: TextBaseline.ideographic),
                              ),
                            )))));
  }
}
