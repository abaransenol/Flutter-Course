import 'dart:async';

import 'package:bloc_sample/data/product_service.dart';
import 'package:bloc_sample/models/product.dart';

class ProductBloc{
  static final productStreamController = StreamController.broadcast();
  static Stream get getStream => productStreamController.stream;

  static List<Product> getProducts(){
    return ProductService.getProducts();
  }
}

final productBloc = ProductBloc();