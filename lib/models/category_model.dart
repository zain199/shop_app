class CategoryDataModel {
  bool status;
  DataModel data;

  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ?  DataModel.fromJson(json['data']) : null;
  }

}

class DataModel {
  List<CategoryData> data = [];
  DataModel.fromJson(Map<String, dynamic> json) {

      json['data'].forEach((v) {
        data.add(CategoryData.fromJson(v));
      });
  }
}

class CategoryData {
  int id;
  String name;
  String image;

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

}