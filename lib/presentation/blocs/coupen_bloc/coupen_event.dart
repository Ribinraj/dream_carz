part of 'coupen_bloc.dart';

@immutable
sealed class CoupenEvent {}

final class CoupenButtonClickEvent extends CoupenEvent {
  final String coupencode;

  CoupenButtonClickEvent({required this.coupencode});
}
