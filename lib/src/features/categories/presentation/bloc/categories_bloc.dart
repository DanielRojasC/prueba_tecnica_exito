import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tecnica_exito/src/core/error/exception.dart';
import 'package:prueba_tecnica_exito/src/core/error/exception_entity.dart';
import 'package:prueba_tecnica_exito/src/features/categories/domain/entities/category_entity.dart';
import 'package:prueba_tecnica_exito/src/features/categories/domain/usecases/get_all_categories_usecase.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetAllCategoriesUsecase getAllCategoriesUsecase;

  CategoriesBloc({required this.getAllCategoriesUsecase})
    : super(CategoriesInitialState()) {
    on<GetCategoriesEvent>((event, emit) => _getCategories(event, emit));
    on<CategoriesInitialEvent>((_, emit) => emit(CategoriesInitialState()));
  }

  Future<void> _getCategories(
    CategoriesEvent event,
    Emitter<CategoriesState> emit,
  ) async {
    try {
      emit(CategoriesLoadingState());

      final List<CategoryEntity> categories = await getAllCategoriesUsecase
          .call(params: null);

      emit(CategoriesLoadedState(categories: categories));
    } on BasicException catch (e) {
      emit(
        CategoryErrorState(
          exception: ExceptionEntity(
            code: e.exception.code,
            message: e.exception.message,
          ),
        ),
      );
    }
  }
}
