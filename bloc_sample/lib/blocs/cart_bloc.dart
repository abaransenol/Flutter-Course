import 'dart:async';

import 'package:bloc_sample/data/cart_service.dart';
import 'package:bloc_sample/models/cart_item.dart';

class CartBloc{
  static final cartStreamController = StreamController.broadcast();
  static Stream get getStream => cartStreamController.stream;

  static void addToCart(CartItem item){
    CartService.addToCart(item);
    cartStreamController.sink.add(CartService.getCart());
  }

  static void removeFromCart(CartItem item){
    CartService.removeFromCart(item);
    cartStreamController.sink.add(CartService.getCart());
  }

  static List<CartItem> getCart(){
    return CartService.getCart();
  }
}

final cartBloc = CartBloc();