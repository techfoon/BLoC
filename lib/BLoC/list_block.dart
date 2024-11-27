

import 'package:bloc_sm/BLoC/list_event.dart';
import 'package:bloc_sm/BLoC/list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListBLoc extends Bloc<ListEvent, ListState> {
  ListBLoc() : super(ListState(mData: [])) {
    on<AdditionMapEvent>(
      (event, emit) {

   


        emit(ListState(mData: [...state.mData, ...event.passingData]));
      },
    );
  } //initial state
}
