part of 'fetch_cities_bloc.dart';

@immutable
sealed class FetchCitiesEvent {}
final class FetchcitiesInitialEvent extends FetchCitiesEvent{}