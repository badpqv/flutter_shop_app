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
  }
}
