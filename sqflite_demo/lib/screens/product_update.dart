import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/dbHelper.dart';
import '../models/product.dart';

class ProductUpdate extends StatelessWidget{
  late Product product;

  late TextEditingController txtName;
  late TextEditingController txtDescription;
  late TextEditingController txtUnitPrice;

  ProductUpdate(Product product){
    this.product = product;

    txtName = TextEditingController(text: product.name);
    txtDescription = TextEditingController(text: product.description);
    txtUnitPrice = TextEditingController(text: product.unitPrice.toString());
  }

  DbHelper dbHelper = DbHelper();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update a product"),
        backgroundColor: Colors.black87,
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          children: [
            buildNameField(),
            buildDescriptionField(),
            buildUnitPriceField(),
            buildUpdateButton(context),
            buildDeleteButton(context)
          ],
        ),
      ),
    );
  }

  TextFormField buildNameField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: "Name",
        hintText: "Laptop",
      ),
      controller: txtName,
    );
  }

  TextFormField buildDescriptionField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: "Description",
        hintText: "Kind of computer",
      ),
      controller: txtDescription,
    );
  }

  TextFormField buildUnitPriceField() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: "Unit Price (\$)",
        hintText: "350",
      ),
      controller: txtUnitPrice,
    );
  }

  ElevatedButton buildUpdateButton(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black87),
        onPressed: () {
          updateProduct();
          Navigator.pop(context, true);
        },
        child: const Row(
          children: [
            Icon(Icons.update),
            SizedBox(width: 5),
            Text("Update")
          ],
        )
    );
  }

  void updateProduct() async{
    Product updatedProduct = Product.withId(
        id: product.id,
        name: txtName.text,
        description: txtDescription.text,
        unitPrice: double.tryParse(txtUnitPrice.text)
    );

    await dbHelper.updateData(updatedProduct);
  }

  ElevatedButton buildDeleteButton(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black87),
        onPressed: () {
          deleteProduct();
          Navigator.pop(context, true);
        },
        child: const Row(
          children: [
            Icon(Icons.delete),
            SizedBox(width: 5),
            Text("Delete")
          ],
        )
    );
  }

  void deleteProduct() async {
    await dbHelper.deleteData(product.id!);
  }
}