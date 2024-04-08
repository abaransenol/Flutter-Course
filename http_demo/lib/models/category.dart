class Category{
  int? id;
  late String categoryName;
  late String seoUrl;

  Category({required this.categoryName, required this.seoUrl});
  Category.withId({required this.id, required this.categoryName, required this.seoUrl});

  Category.fromJson(Map json){
    var rawId = json["id"];
    if(rawId.runtimeType == String){
      id = int.tryParse(json["id"]);
    } else {
      id = rawId;
    }
    categoryName = json["categoryName"].toString();
    seoUrl = json["seoUrl"].toString();
  }

  Map toJson(){
    return {
      "id" : id,
      "categoryName" : categoryName,
      "seoUrl" : seoUrl
    };
  }
}