part of 'categories_bloc.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitialState extends CategoriesState {}

final class CategoriesLoadingState extends CategoriesState {}

final class CategoriesLoadedState extends CategoriesState {
  final List<CategoryEntity> categories;

  CategoriesLoadedState({required this.categories});
}

final class CategoryErrorState extends CategoriesState {
  final ExceptionEntity exception;
  CategoryErrorState({required this.exception});
}
