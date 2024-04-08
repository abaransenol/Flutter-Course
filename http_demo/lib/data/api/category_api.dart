import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class CategoryApi{
  static Future<Response> getCategories() {
    Uri uri = Uri(scheme: "http", host: "localhost", port: 3000, path: "/categories");
    return http.get(uri);
  }
}