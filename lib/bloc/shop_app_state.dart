part of 'shop_app_bloc.dart';

abstract class ShopAppState extends Equatable {
  const ShopAppState();
  
  @override
  List<Object> get props => [];
}

class ShopAppInitial extends ShopAppState {}
