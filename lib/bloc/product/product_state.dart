part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductDeleting extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final List<Category> categories;
  const ProductLoaded({required this.products, this.categories = const []});
  @override
  List<Object> get props => [products, categories];
}
