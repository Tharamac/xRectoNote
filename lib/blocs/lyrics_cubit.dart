import 'package:bloc/bloc.dart';
import 'package:x_rectonote/note_sequence.dart';
import 'package:x_rectonote/project_entity.dart';

class NoteSequenceCubit extends Cubit<List<NoteSequence>> {
  NoteSequenceCubit() : super([]);

  void initList(List<NoteSequence> melodyEvents) => emit(List.of(melodyEvents));
}
