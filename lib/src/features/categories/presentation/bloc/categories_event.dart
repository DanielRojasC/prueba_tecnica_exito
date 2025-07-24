part of 'categories_bloc.dart';

@immutable
sealed class CategoriesEvent {}

final class GetCategoriesEvent extends CategoriesEvent {}

final class CategoriesInitialEvent extends CategoriesEvent {}
