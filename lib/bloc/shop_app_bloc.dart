import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shop_app_event.dart';
part 'shop_app_state.dart';

class ShopAppBloc extends Bloc<ShopAppEvent, ShopAppState> {
  ShopAppBloc() : super(ShopAppInitial()) {
    on<ShopAppEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
