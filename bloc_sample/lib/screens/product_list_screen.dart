import 'package:bloc_sample/blocs/cart_bloc.dart';
import 'package:bloc_sample/blocs/product_bloc.dart';
import 'package:bloc_sample/models/cart_item.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text("Shopping System"),
        actions: <Widget>[
          IconButton(
              onPressed: () => Navigator.pushNamed(context, "/cart"),
              icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: buildProductList(),
    );
  }

  buildProductList() {
    return StreamBuilder(
        initialData: ProductBloc.getProducts(),
        stream: ProductBloc.getStream,
        builder: (context, snapshot){
          return snapshot.data.length > 0 ? buildProductListItems(snapshot) : Center(child: Text("No Data"));
        }
    );
  }

  buildProductListItems(AsyncSnapshot<dynamic> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(snapshot.data[index].name),
            subtitle: Text("\$${snapshot.data[index].price}"),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: (){
                CartBloc.addToCart(CartItem(
                    product: snapshot.data[index],
                    amount: 1
                ));
              },
            )
          );
        }
    );
  }
}