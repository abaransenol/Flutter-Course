import 'package:bloc_sample/models/product.dart';

class ProductService{
  ProductService._internal();
  static final ProductService _singleton = ProductService._internal();
  factory ProductService(){
    return _singleton;
  }

  static List<Product> products = [
    Product(id: 1, name: "hey", price: 10),
    Product(id: 2, name: "trigga", price: 30),
    Product(id: 3, name: "nygga", price: 50),
  ];

  static List<Product> getProducts(){
    return products;
  }
}