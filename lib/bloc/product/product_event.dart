part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductsList extends ProductEvent {}

class GetFilteredProductsList extends ProductEvent {}

class AddProduct extends ProductEvent {}
