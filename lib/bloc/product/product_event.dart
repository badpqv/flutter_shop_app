part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductsList extends ProductEvent {}

class GetFilteredProductsList extends ProductEvent {
  final Category category;
  const GetFilteredProductsList({required this.category});

  @override
  List<Object> get props => [category];
}

class AddProduct extends ProductEvent {
  final Product product;
  final List<File> images;
  const AddProduct({required this.product, required this.images});

  @override
  List<Object> get props => [product];
}

class EditProduct extends ProductEvent {
  final Product product;
  final List<File> images;
  const EditProduct({required this.product, required this.images});

  @override
  List<Object> get props => [product];
}

class DeleteProduct extends ProductEvent {
  final Product product;
  const DeleteProduct({required this.product});

  @override
  List<Object> get props => [product];
}
