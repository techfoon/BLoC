import 'package:bloc_sm/BLoC/counter_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBLoc extends Bloc<CounterEvent, int> {
  CounterBLoc() : super(0) {
    on<IncrementCounterEvent>(
      (event, emit) {
        emit(state + 1);
      },
    );

    on<DecrementCounterEvent>(
      (event, emit) {
        if (state > 0) {
          emit(state - 1);
        }
      },
    );
  } //initial state
}
