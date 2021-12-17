class FavoritesDataModel {
  bool status;
  DataModel data;


  FavoritesDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ?  DataModel.fromJson(json['data']) : null;
  }

}

class DataModel {
  List<FavoriteData> data=[];

  DataModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((v) {
      data.add(FavoriteData.fromJson(v));
    });
  }

}

class FavoriteData {
  ProductData product;

  FavoriteData.fromJson(Map<String, dynamic> json) {
    product = json['product'] != null ?  ProductData.fromJson(json['product']) : null;
  }

}

class ProductData {
  int id;
  int price;
  int oldPrice;
  int discount;
  String image;
  String name;
  String description;


  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'].round();
    oldPrice = json['old_price'].round();
    discount = json['discount'].round();
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}
