import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite_demo/data/dbHelper.dart';

import '../models/product.dart';

class ProductAdd extends StatelessWidget{
  DbHelper dbHelper = DbHelper();

  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtUnitPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a product"),
        backgroundColor: Colors.black87,
      ),
      
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          children: [
            buildNameField(),
            buildDescriptionField(),
            buildUnitPriceField(),
            buildAddButton(context)
          ],
        ),
      ),
    );
  }

  TextField buildNameField() {
    return TextField(
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: "Name",
        hintText: "Laptop",
      ),
      controller: txtName,
    );
  }

  TextField buildDescriptionField() {
    return TextField(
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: "Description",
        hintText: "Kind of computer",
      ),
      controller: txtDescription,
    );
  }

  TextField buildUnitPriceField() {
    return TextField(
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: "Unit Price (\$)",
        hintText: "350",
      ),
      controller: txtUnitPrice,
    );
  }

  ElevatedButton buildAddButton(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black87),
        onPressed: () {
          addProduct();
          Navigator.pop(context, true);
        },
        child: const Row(
          children: [
            Icon(Icons.add),
            SizedBox(width: 5),
            Text("Add")
          ],
        )
    );
  }

  void addProduct() async{
    Product product = Product(
        name: txtName.text,
        description: txtDescription.text,
        unitPrice: double.tryParse(txtUnitPrice.text)
    );
    var result = await dbHelper.insertData(product);
  }
}