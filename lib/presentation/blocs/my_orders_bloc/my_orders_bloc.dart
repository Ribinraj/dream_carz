import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dream_carz/data/ordermodel.dart';
import 'package:dream_carz/domain/repositories/apprepo.dart';
import 'package:meta/meta.dart';

part 'my_orders_event.dart';
part 'my_orders_state.dart';

class MyOrdersBloc extends Bloc<MyOrdersEvent, MyOrdersState> {
  final Apprepo repository;
  MyOrdersBloc({required this.repository}) : super(MyOrdersInitial()) {
    on<MyOrdersEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<MyordersInitialFetchingEvent>(fetchorders);
  }

  FutureOr<void> fetchorders(
    MyordersInitialFetchingEvent event,
    Emitter<MyOrdersState> emit,
  ) async {
    emit(MyordersLoadingState());
    try {
      final response = await repository.myorders();
      if (!response.error && response.status == 200) {
        emit(MyordersSuccessState(orders: response.data!));
      } else {
        emit(MyordersErrorState(message: response.message));
      }
    } catch (e) {
      emit(MyordersErrorState(message: e.toString()));
    }
  }
}
