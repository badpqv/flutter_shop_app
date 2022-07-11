import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/api_repository/api_repository.dart';
import 'package:flutter_shop_app/models/nofification_model.dart';
import 'package:flutter_shop_app/models/shopping_cart_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final User user;

  CartBloc({required this.user}) : super(CartInitial()) {
    final ApiRepository repository = ApiRepository();
    on<GetCartList>(
      (event, emit) async {
        // TODO: implement event handler
        try {
          emit(CartLoading());
          final carts = await repository.fetchCurrentUserCart(user);
          emit(CartLoaded(carts: carts));
        } on NetworkError {
          emit(const CartLoaded(carts: <Cart>[]));
        }
      },
    );
    on<AddCart>(
      (event, emit) async {
        if (state is CartLoaded) {
          try {
            await repository.postCart(event.cart);
            var cartsAfterPost = await repository.fetchCurrentUserCart(user);
            emit(
              CartLoaded(
                carts: cartsAfterPost,
              ),
            );
          } on NetworkError {
            emit(const CartLoaded(carts: <Cart>[]));
          }
        }
      },
    );
    on<DeleteCart>(
      (event, emit) async {
        if (state is CartLoaded) {
          final state = this.state as CartLoaded;
          try {
            var carts = await repository.fetchCurrentUserCart(user);
            var cart = carts.firstWhere(
              (element) =>
                  element.userId == event.cart.userId &&
                  element.id == event.cart.id,
            );
            var cartsAfterDelete =
                await repository.deleteCart(int.parse(cart.id), user);
            emit(
              CartLoaded(
                carts: cartsAfterDelete,
              ),
            );
          } on NetworkError {
            emit(const CartLoaded(carts: <Cart>[]));
          }
        }
      },
    );
    on<AddNotification>(
      (event, emit) async {
        if (state is NotificationLoaded) {
          try {
            await repository.sendNotification(event.notification);
            var notificationAfterPost =
                await repository.fetchNotificationsList();
            emit(
              NotificationLoaded(
                notifications: notificationAfterPost,
              ),
            );
          } on NetworkError {
            emit(
              const NotificationLoaded(
                notifications: <AppNotification>[],
              ),
            );
          }
        }
      },
    );
  }
}
