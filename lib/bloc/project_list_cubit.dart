import 'package:bloc/bloc.dart';
import 'package:x_rectonote/project_entity.dart';

class ProjectListCubit extends Cubit<List<SongProject>> {
  ProjectListCubit()
      : super([
          SongProject(id: 1, songName: "New"),
          SongProject(id: 2, songName: "Blah3x")
        ]);
}
