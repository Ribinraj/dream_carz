part of 'fetch_banners_bloc.dart';

@immutable
sealed class FetchBannersState {}

final class FetchBannersInitial extends FetchBannersState {}

final class FetchBannersLoadingState extends FetchBannersState {}

final class FetchBannersSuccessState extends FetchBannersState {
  final List<BannerDataModel> banners;

  FetchBannersSuccessState({required this.banners});
}

final class FetchBannersErrorState extends FetchBannersState {
  final String message;

  FetchBannersErrorState({required this.message});
}
