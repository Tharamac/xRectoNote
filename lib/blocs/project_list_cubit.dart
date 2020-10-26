import 'package:bloc/bloc.dart';
import 'package:x_rectonote/model/project_entity.dart';

class ProjectListCubit extends Cubit<List<SongProject>> {
  ProjectListCubit() : super([]);

  void initProjectList(List<SongProject> songlist) {
    emit(List.of(songlist));
  }

  void newSongProject(SongProject s) {
    emit(state.followedBy([s]).toList());
  }
}
