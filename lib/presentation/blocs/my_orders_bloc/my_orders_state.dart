part of 'my_orders_bloc.dart';

@immutable
sealed class MyOrdersState {}

final class MyOrdersInitial extends MyOrdersState {}

final class MyordersLoadingState extends MyOrdersState {}

final class MyordersSuccessState extends MyOrdersState {
  final List<Ordermodel> orders;

  MyordersSuccessState({required this.orders});
}

final class MyordersErrorState extends MyOrdersState {
  final String message;

  MyordersErrorState({required this.message});
}
