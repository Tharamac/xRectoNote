import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_rectonote/bloc/project_list_cubit.dart';
import 'package:x_rectonote/config/colors_theme.dart';
import 'package:x_rectonote/project_entity.dart';
import 'package:x_rectonote/widgets/project_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "xRectoNote",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: RectoNoteColors.colorPrimary,
              fontSize: 32,
              fontWeight: FontWeight.w700),
        ),
        backgroundColor: RectoNoteColors.appBarColor,
      ),
      body: Center(child: BlocBuilder<ProjectListCubit, List<SongProject>>(
          builder: (context, state) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: state.length,
          itemBuilder: (BuildContext context, int i) {
            return ProjectItemCard(
              songName: state[i].songName,
            );
          },
        );
      })),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
