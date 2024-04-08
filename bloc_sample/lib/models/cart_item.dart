import 'package:bloc_sample/models/product.dart';

class CartItem {
  late Product product;
  late int amount;

  CartItem({required this.product, required this.amount});
}