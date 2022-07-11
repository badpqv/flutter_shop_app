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

class LoadNotificationsList extends CartEvent {}

class AddNotification extends CartEvent {
  final AppNotification notification;
  const AddNotification({required this.notification});

  @override
  List<Object> get props => [notification];
}

class MarkNotificationAsRead extends CartEvent {}

class MarkAllNotificationAsRead extends CartEvent {}
