import 'package:bloc_sample/blocs/cart_bloc.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Your cart"),
      ),
      body: buildCart(),
    );
  }

  buildCart() {
    return StreamBuilder(
        initialData: CartBloc.getCart(),
        stream: CartBloc.getStream,
        builder: (context, snapshot) {
          return snapshot.data.length > 0 ? buildCartItems(snapshot) : Center(child: Text("No Data Found"));
        });
  }

  buildCartItems(AsyncSnapshot<dynamic> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(snapshot.data[index].product.name),
            subtitle: Text("${snapshot.data[index].amount} in cart, \$${(snapshot.data[index].product.price) * snapshot.data[index].amount} in total."),
            trailing: IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                CartBloc.removeFromCart(snapshot.data[index]);
              },
            ),
          );
        });
  }
}
