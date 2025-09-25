part of 'fetch_cars_bloc.dart';

@immutable
sealed class FetchCarsState {}

final class FetchCarsInitial extends FetchCarsState {}

final class FetchCarsLoadingState extends FetchCarsState {}

final class FetchCarsSuccessState extends FetchCarsState {
  final List<CarsModel> cars;

  FetchCarsSuccessState({required this.cars});
}

final class FetchCarsErrorState extends FetchCarsState {
  final String message;

  FetchCarsErrorState({required this.message});
}
