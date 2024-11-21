import 'package:bloc_sm/BLoC/counter_event.dart';
import 'package:bloc_sm/BLoC/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBLoc extends Bloc<CounterEvent, CounterState> {
  CounterBLoc() : super(CounterState(count: 0)) {
    on<IncrementCounterEvent>(
      (event, emit) {
        emit(CounterState(count: state.count + 1));
      },
    );

    on<DecrementCounterEvent>(
      (event, emit) {
        if (state.count > 0) {
          emit(CounterState(count: state.count - 1));
        }
      },
    );
  } //initial state
}
