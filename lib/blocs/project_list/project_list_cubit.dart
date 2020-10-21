import 'package:bloc/bloc.dart';
import 'package:x_rectonote/project_entity.dart';

class ProjectListCubit extends Cubit<List<SongProject>> {
  ProjectListCubit()
      : super([
          SongProject(id: 0, songName: "New"),
          SongProject(id: 1, songName: "Blah3x")
        ]);

  void newSongProject(SongProject s) {
    emit(state.followedBy([s]).toList());
  }
}
