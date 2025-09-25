part of 'fetch_categories_bloc.dart';

@immutable
sealed class FetchCategoriesState {}

final class FetchCategoriesInitial extends FetchCategoriesState {}

final class FetchCategoriesLoadingState extends FetchCategoriesState {}

final class FetchCategoriesSuccessState extends FetchCategoriesState {
  final List<CategoriesModel> categories;

  FetchCategoriesSuccessState({required this.categories});
}

final class FetchCategoriesErrorState extends FetchCategoriesState {
  final String message;

  FetchCategoriesErrorState({required this.message});
}
