import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:x_rectonote/blocs/lyrics_cubit.dart';

import 'package:x_rectonote/blocs/project_list_cubit.dart';
import 'package:x_rectonote/blocs/bloc_observer.dart';
import 'package:x_rectonote/config/colors_theme.dart';
import 'package:x_rectonote/config/routes.dart';
import 'package:x_rectonote/model/storage.dart';
import 'package:x_rectonote/pages/home_page.dart';
import 'package:x_rectonote/pages/piano_roll_lyrics_mapper_page.dart';

import 'config/colors_theme.dart';
import 'config/routes.dart';
import 'pages/lyrics_data.dart';
import 'pages/lyrics_data.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProjectListCubit>(
          create: (BuildContext context) => ProjectListCubit(),
        ),
        BlocProvider<NoteSequenceCubit>(
            create: (BuildContext context) => NoteSequenceCubit())
      ],
      child: MaterialApp(
        title: 'xRectoNote',
        theme: ThemeData(
          fontFamily: "JosefinSans",
          brightness: Brightness.dark,
          backgroundColor: RectoNoteColors.colorBackground,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          hintColor: RectoNoteColors.colorPrimaryDark,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              foregroundColor: RectoNoteColors.colorPrimaryDark,
              backgroundColor: RectoNoteColors.colorPrimary),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.home: (context) => HomePage(SongProjectStorage()),
          //AppRoutes.editScorePage: (context) => EditScorePage()
        },
        onGenerateRoute: _regRoutesWithParams,
      ),
    );
  }
}

// ignore: missing_return
Route _regRoutesWithParams(RouteSettings settings) {
  if (settings.name == AppRoutes.lyricsDataPage) {
    return MaterialPageRoute(builder: (context) {
      LyricsDataParam param = settings.arguments;
      return LyricsDataPage(param.selectedDataIdx);
    });
  } else if (settings.name == AppRoutes.pianoRollMapperPage) {
    // ignore: missing_return
    return MaterialPageRoute(builder: (context) {
      var param = settings.arguments;
      if (param is LyricsMapperAddNewParam) {
        return PianoRollLyricsMapperPage.addNew(param.songName, param.midiPath);
      } else if (param is LyricsMapperEditExistParam) {
        return PianoRollLyricsMapperPage(
            param.idx, param.songName, param.midi, param.trackDuration);
      }
    });
  }
}
