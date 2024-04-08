import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_demo/data/api/category_api.dart';
import 'package:http_demo/data/api/product_api.dart';
import '../models/category.dart';
import '../models/product.dart';

class MainScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MainScreen();
  }
}

class _MainScreen extends State{
  late Category selectedCategory;
  late Widget selectedWidget;

  List<Category> categories = [];
  List<Widget> categoryWidgets = [];

  List<Product> products = [];
  List<Widget> productWidgets = [];

  @override
  void initState() {
    super.initState();
    buildCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping System", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black87,
        centerTitle: true,
      ),
      
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categoryWidgets,
                ),
              ),
            ),

            ListView.builder(
                itemCount: products.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index){
                  return productWidgets[index];
            })
          ],
        ),
      ),
    );
  }





  void buildCategories() async {
    CategoryApi.getCategories().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        categories = list.map((category) => Category.fromJson(category)).toList();
        buildCategoryWidgets();
      });
    });
  }

  void buildCategoryWidgets() {
    for(int i=0; i<categories.length; i++){
      categoryWidgets.add(buildCategoryWidget(categories[i]));
      categoryWidgets.add(SizedBox(width: 2.5));
    }
    categoryWidgets.removeAt(categories.length-1);
  }

  Widget buildCategoryWidget(Category category){
    return ElevatedButton(
      child: Text(category.categoryName, style: TextStyle(color: Colors.black87)),
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shadowColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.deepOrange),
          ),
      ),
      onPressed: (){
        setState(() {
          selectedCategory = category;
          buildProducts();
        });
      },
    );
  }





  void buildProducts() async {
    ProductApi.getProductsByCategoryId(selectedCategory.id!).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        products = list.map((product) => Product.fromJson(product)).toList();
        buildProductsWidgets();
      });
    });
  }

  void buildProductsWidgets() {
    productWidgets = [];
    for (int i=0; i<products.length; i++){
      productWidgets.add(buildProductWidgets(products[i]));
    }
  }

  Widget buildProductWidgets(Product product) {
    return ListTile(
      title: Text("${product.productName}: \$${product.unitPrice}"),
      subtitle: Text("${product.quantityPerUnit}, ${product.unitsInStock} in stock"),
    );
  }
}