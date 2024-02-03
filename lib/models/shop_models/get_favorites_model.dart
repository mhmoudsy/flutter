class FavoritesModel{
  late bool status;
  String? message;
  FavoritesData? data;
  FavoritesModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=FavoritesData.fromJson(json['data']);
  }

}
class FavoritesData{
  List<FavoritesProductData> data=[];
  FavoritesData.fromJson(Map<String,dynamic>json){
    json['data'].forEach((element){
      data.add(FavoritesProductData.fromJson(element));
    });
  }

}
class FavoritesProductData{
  int? id;
  ProductData? product;
  FavoritesProductData.fromJson(Map<String,dynamic>json){
    id = json['id'];
    product=ProductData.fromJson(json['product']);
  }
}
class ProductData{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  ProductData.fromJson(Map<String,dynamic>json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}