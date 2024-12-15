import 'package:bloc_sm/BLoC/list_event.dart';
import 'package:bloc_sm/BLoC/list_state.dart';
import 'package:bloc_sm/local/db_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesBloc extends Bloc<ListEvent, NotesState> {
  DBHelper db;
  NotesBloc({required this.db}) : super(NotesInitaialState()) {
    on<AdditionMapEvent>(
      (event, emit) async {
        emit(NotesLoadingState());

        bool check =
            await db.addNote(title: event.title, desc: event.description);

        if (check) {
          var AllNotes = await db.getAllNotes();

          emit(NotesLoadedState(stateArrNotes: AllNotes));
        } else {
          emit(NotesErroState(errMsg: " Notes Not ADDED"));
        }

        //  emit(NotesState( stateArrNotes: [...state.stateArrNotes, ...addiontiondata]));
      },
    );

    on<FetchMapEvent>((event, emit) async {
      emit(NotesLoadingState());

      List<Map<String, dynamic>> AllNotes = await db.getAllNotes();

      emit(NotesLoadedState(stateArrNotes: AllNotes));
    });
/*
 on<RemoveMapEvent>(
      (event, emit) {
// Create a new list without mutating the existing one
        final updatedData =
            List<Map<String, dynamic>>.from(state.stateArrNotes);
        updatedData.removeAt(event.passingIndex);

        // Emit the updated state
        emit(NotesState(stateArrNotes: updatedData));

        // emit(NotesState( stateArrNotes: [state. stateArrNotes.removeAt(event.passingIndex)]));
      },
    );

    on<UpdateMapEvent>((event, emit) {
      List<Map<String, dynamic>> updateData = state.stateArrNotes;

      updateData[event.passingIndex] = {
        "name": event.title,
        "descrtion": event.description
      };

      emit(NotesState(stateArrNotes: updateData));
    });*/
  } //initial state
}
