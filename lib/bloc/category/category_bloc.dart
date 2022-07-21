import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/api_repository/api_repository.dart';
import 'package:flutter_shop_app/models/category_model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    final ApiRepository repository = ApiRepository();

    on<GetCategoriesList>((event, emit) async {
      emit(CategoryLoading());
      var categories = await repository.fetchCategoriesList();
      emit(
        CategoryLoaded(
          categories: categories
            ..sort(
              (a, b) => a.title.compareTo(b.title),
            ),
        ),
      );
    });
    on<AddCategory>((event, emit) async {
      emit(CategoryLoading());
      await repository.saveImage(
          "Category_${event.category.title.replaceAll(" ", "")}", event.image);
      var extension = event.image.path.split("/").last.split(".").last;
      var imgName =
          event.category.title.replaceAll(" ", "").replaceAll(":", '');

      var category = Category(
        id: event.category.id,
        icon:
            "http://192.168.1.5:5000/images/Category_$imgName.${extension == "webp" ? "jpg" : extension}",
        title: event.category.title,
      );
      await repository.postCategory(category);
      var categoriesAfterPost = await repository.fetchCategoriesList();
      emit(
        CategoryLoaded(
          categories: categoriesAfterPost
            ..sort(
              (a, b) => a.title.compareTo(b.title),
            ),
        ),
      );
    });
    on<DeleteCategory>((event, emit) async {
      await repository.deleteCategory(int.parse(event.category.id));
      var categoriesAfterDelete = await repository.fetchCategoriesList();
      emit(
        CategoryLoaded(
          categories: categoriesAfterDelete
            ..sort(
              (a, b) => a.title.compareTo(b.title),
            ),
        ),
      );
    });
  }
}
