import 'package:bloc_sample/models/cart_item.dart';

class CartService{
  CartService._internal();
  static final CartService _singleton = CartService._internal();
  factory CartService(){
    return _singleton;
  }

  static List<CartItem> cart = [];

  static void addToCart(CartItem item){
    for(CartItem cartItem in cart){
      if(cartItem.product.id == item.product.id){
        cartItem.amount++;
        return;
      }
    }

    cart.add(item);
  }

  static void removeFromCart(CartItem item){
    for(CartItem cartItem in cart){
      if(cartItem.product.id == item.product.id){
        if (cartItem.amount == 1){
          cart.remove(item);
        } else {
          cartItem.amount--;
        }
        return;
      }
    }
  }

  static List<CartItem> getCart(){
    return cart;
  }
}