import 'package:flutter/material.dart';
import 'package:sqflite_demo/models/product.dart';
import 'package:sqflite_demo/screens/product_add.dart';
import 'package:sqflite_demo/screens/product_update.dart';
import '../data/dbHelper.dart';

class ProductList extends StatefulWidget {
  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  DbHelper dbHelper = DbHelper();
  List<Product> products = [];
  int productCount = 0;

  @override
  void initState() {
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("List of products"),
      ),

      body: buildProductsList(context),

      floatingActionButton: FloatingActionButton(
          onPressed: () {
            goToProductAdd();
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.black87,
          tooltip: "Add a new product",
      ),
    );
  }

  ListView buildProductsList(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.black87,
          elevation: 2.0,
          child: ListTile(
            title: Text("${products[index].name!} - \$${products[index].unitPrice}", style: TextStyle(color: Colors.white70)),
            subtitle: Text("${products[index].description}", style: TextStyle(color: Colors.white54),),
            onTap: (){
              goToProductUpdate(index);
            },
            onLongPress: (){
              productDelete(index);
            },
          ),
        );
      },
    );
  }




  void getProducts() async{
    await dbHelper.getProducts().then((value) {
      products = value;
      productCount = value.length;
    });
  }

  void goToProductAdd() async{
    var result = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductAdd()));
    if (result != null && result){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          getProducts();
        });
      });
    }
  }

  void productDelete(int index) async{
    await dbHelper.deleteData(products[index].id!);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        getProducts();
      });
    });
  }

  void goToProductUpdate(int index) async{
    var result = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductUpdate(products[index])));
    if (result != null && result){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          getProducts();
        });
      });
    }
  }
}
