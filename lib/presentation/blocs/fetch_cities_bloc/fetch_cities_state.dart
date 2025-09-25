part of 'fetch_cities_bloc.dart';

@immutable
sealed class FetchCitiesState {}

final class FetchCitiesInitial extends FetchCitiesState {}

final class FetchCitiesLoadingState extends FetchCitiesState {}

final class FetchCitiesSuccessState extends FetchCitiesState {
  final List<CityModel> cities;

  FetchCitiesSuccessState({required this.cities});
}

final class FetchCitiesErrorState extends FetchCitiesState {
  final String message;

  FetchCitiesErrorState({required this.message});
}
