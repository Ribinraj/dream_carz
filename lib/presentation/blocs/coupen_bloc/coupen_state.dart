part of 'coupen_bloc.dart';

@immutable
sealed class CoupenState {}

final class CoupenInitial extends CoupenState {}

final class CoupenLoadingState extends CoupenState {}

final class CoupenSuccessState extends CoupenState {
  final CouponModel coupen;

  CoupenSuccessState({required this.coupen});
}

final class CoupenErrorState extends CoupenState {
  final String message;

  CoupenErrorState({required this.message});
}
