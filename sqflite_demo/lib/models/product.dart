class Product{
  int? id;
  String? name;
  String? description;
  double? unitPrice;

  Product({this.name, this.description, this.unitPrice});
  Product.withId({this.id, this.name, this.description, this.unitPrice});

  Map<String, Object?> toMap() {
    return <String, Object?> {
      "id" : id,
      "name" : name,
      "description" : description,
      "unitPrice" : unitPrice
    };
  }

  Product.fromObject(dynamic object){
    this.id = object["id"];
    this.name = object["name"];
    this.description = object["description"];
    this.unitPrice = object["unitPrice"];
  }

}