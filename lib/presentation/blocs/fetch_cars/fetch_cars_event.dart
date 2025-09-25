part of 'fetch_cars_bloc.dart';

@immutable
sealed class FetchCarsEvent {}

final class FetchCarsButtonClickEvent extends FetchCarsEvent {
  final SearchModel search;

  FetchCarsButtonClickEvent({required this.search});
}
