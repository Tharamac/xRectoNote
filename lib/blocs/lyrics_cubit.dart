import 'package:bloc/bloc.dart';
import 'package:x_rectonote/model/note_sequence.dart';
import 'package:x_rectonote/model/project_entity.dart';

class NoteSequenceCubit extends Cubit<List<NoteSequence>> {
  NoteSequenceCubit() : super([]);

  void initList(List<NoteSequence> melodyEvents) => emit(List.of(melodyEvents));
}
