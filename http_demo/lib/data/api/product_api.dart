import 'package:http/http.dart' as http;

class ProductApi{
  static Future getProducts() async {
    return http.get(Uri(scheme: "http", host: "localhost", port: 3000, path: "/products"));
  }

  static Future getProductsByCategoryId(int categoryId) async {
    return http.get(Uri(scheme: "http", host: "localhost", port: 3000, path: "/products", queryParameters: {"categoryId" : categoryId.toString()}));
  }
}