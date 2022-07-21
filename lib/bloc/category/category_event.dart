part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetCategoriesList extends CategoryEvent {}

class GetFilteredCategoriesList extends CategoryEvent {}

class AddCategory extends CategoryEvent {
  final Category category;
  final File image;
  const AddCategory({required this.category, required this.image});

  @override
  List<Object> get props => [category];
}

class DeleteCategory extends CategoryEvent {
  final Category category;
  const DeleteCategory({required this.category});

  @override
  List<Object> get props => [category];
}
