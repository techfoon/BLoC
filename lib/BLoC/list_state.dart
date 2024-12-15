class NotesState {


}

class NotesInitaialState extends NotesState {}

class NotesLoadingState extends NotesState {}

class NotesLoadedState extends NotesState {
  List<Map<String, dynamic>> stateArrNotes = [];

  NotesLoadedState({required this.stateArrNotes});
}

class NotesErroState extends NotesState {
  String errMsg;

  NotesErroState({required this.errMsg});
}
