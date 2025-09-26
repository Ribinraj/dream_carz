part of 'fetch_kmplans_bloc.dart';

@immutable
sealed class FetchKmplansState {}

final class FetchKmplansInitial extends FetchKmplansState {}

final class FetchKmplansLoadingState extends FetchKmplansState {}

final class FetchKmplansSuccessState extends FetchKmplansState {
  final List<KmModel> kmplans;

  FetchKmplansSuccessState({required this.kmplans});
}

final class FetchKmplansErrorState extends FetchKmplansState {
  final String message;

  FetchKmplansErrorState({required this.message});
}
