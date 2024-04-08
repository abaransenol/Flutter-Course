class Product{
  int? id;
  late int categoryId;
  late String productName;
  late String quantityPerUnit;
  late double unitPrice;
  late int unitsInStock;

  Product({required this.categoryId, required this.productName, required this.quantityPerUnit, required this.unitPrice, required this.unitsInStock});
  Product.withId({required this.id, required this.categoryId, required this.productName, required this.quantityPerUnit, required this.unitPrice, required this.unitsInStock});

  Product.fromJson(Map json) {
    var rawId = json["id"];
    if(rawId.runtimeType == String){
      id = int.tryParse(json["id"]);
    } else {
      id = rawId;
    }

    var rawUnitPrice = json["unitPrice"];
    if(rawUnitPrice is String || rawUnitPrice is int){
      unitPrice = double.tryParse(json["unitPrice"].toString())!;
    } else {
      unitPrice = rawUnitPrice;
    }

    var rawUnitsInStock = json["unitsInStock"];
    if(rawUnitsInStock.runtimeType == String){
      unitsInStock = int.tryParse(json["unitsInStock"])!;
    } else {
      unitsInStock = rawUnitsInStock;
    }

    productName = json["productName"].toString();
    quantityPerUnit = json["quantityPerUnit"].toString();
  }

  Map toJson(){
    return {
      "id": id,
      "productName": productName,
      "quantityPerUnit": quantityPerUnit,
      "unitPrice": unitPrice,
      "unitsInStock": unitsInStock
    };
  }
}