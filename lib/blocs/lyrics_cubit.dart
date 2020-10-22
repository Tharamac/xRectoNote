import 'package:bloc/bloc.dart';
import 'package:x_rectonote/project_entity.dart';

class LyricsCubit extends Cubit<List<String>> {
  LyricsCubit() : super([]);

  void insertLyrics(int idx ,String lyric){
    state.insert(idx, lyric);
  }
}
