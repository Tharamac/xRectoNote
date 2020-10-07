import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_rectonote/bloc/project_list_cubit.dart';
import 'package:x_rectonote/bloc/project_list_observer.dart';
import 'package:x_rectonote/config/colors_theme.dart';
import 'package:x_rectonote/config/routes.dart';
import 'package:x_rectonote/pages/home_page.dart';

void main() {
  Bloc.observer = ProjectListObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => ProjectListCubit(),
    child: MaterialApp(
      title: 'xRectoNote',
      theme: ThemeData(
        fontFamily: "Josefin Sans",
        brightness: Brightness.dark,
        backgroundColor: RectoNoteColors.colorBackground,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            foregroundColor: RectoNoteColors.colorPrimaryDark,
            backgroundColor: RectoNoteColors.colorPrimary),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.home: (context) => HomePage(),
        //AppRoutes.editScorePage: (context) => EditScorePage()
      },
      onGenerateRoute: _regRoutesWithParams,
    );,)
  }
}

Route _regRoutesWithParams(RouteSettings settings) {}
