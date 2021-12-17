class HomeDataModel {
  bool status;
  HomeData data;

  HomeDataModel.formJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? HomeData.formJson(json['data']) : null;
  }
}

class HomeData {
  List<Banner> bannaers=[];
  List<Product> products=[];

  HomeData.formJson(Map<String, dynamic> json) {
    for (int i = 0; i < json['banners'].length; i++) {
      bannaers.add(Banner.fromJson(json['banners'][i]));
    }

    for (int i = 0; i < json['products'].length; i++) {
      products.add(Product.fromJson(json['products'][i]));
    }
  }
}

class Banner {
  int id;

  String image;

  Banner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class Product {
  int id;

  String image;
  int price;
  int discount;
  int oldprice;
  bool inFavorite;
  bool inCart;
  String name;
  String description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    price = json['price'].round();
    oldprice = json['old_price'].round();
    inFavorite = json['in_favorites'];
    inCart = json['in_cart'];
    name = json['name'];
    description = json['description'];
    discount = json['discount'];
  }
}
