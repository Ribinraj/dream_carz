part of 'fetch_kmplans_bloc.dart';

@immutable
sealed class FetchKmplansEvent {}
final class FetchKmplansInitialEvent extends FetchKmplansEvent{}