part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetCategoriesList extends CategoryEvent {}

class GetFilteredCategoriesList extends CategoryEvent {}

class AddCategory extends CategoryEvent {}
