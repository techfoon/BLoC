import 'package:bloc_sm/BLoC/list_event.dart';
import 'package:bloc_sm/BLoC/list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListBLoc extends Bloc<ListEvent, ListState> {
  ListBLoc() : super(ListState(mData: [])) {
    on<AdditionMapEvent>(
      (event, emit) {
        final List<Map<String, dynamic>> addiontiondata = [{"name": event.title, "descrtion": event.description}];
        emit(ListState(mData: [...state.mData, ...addiontiondata ]));
      },
    );

    on<RemoveMapEvent>(
      (event, emit) {
// Create a new list without mutating the existing one
        final updatedData = List<Map<String, dynamic>>.from(state.mData);
        updatedData.removeAt(event.passingIndex);

        // Emit the updated state
        emit(ListState(mData: updatedData));

        // emit(ListState(mData: [state.mData.removeAt(event.passingIndex)]));
      },
    );
  } //initial state
}
