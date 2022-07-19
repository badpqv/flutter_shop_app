part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GetCartList extends CartEvent {}

class AddCart extends CartEvent {
  final Cart cart;

  const AddCart({required this.cart});
  @override
  List<Object> get props => [cart];
}

class DeleteCart extends CartEvent {
  final Cart cart;

  const DeleteCart({required this.cart});
  @override
  List<Object> get props => [cart];
}
