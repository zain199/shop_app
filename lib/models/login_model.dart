class LoginModel {

  bool status;
  String message;
  LoginDataModel data;

  LoginModel.fromJson(Map<String, dynamic> json)
  {
    this.status= json['status'];
    this.message= json['message'];
    this.data= json['data'] !=null ? LoginDataModel.fromJson(json['data']): null;
  }

}

class LoginDataModel {
  int id;
  String name;
  String email;
  String phone;
  String image;
  int points;
  int credit;
  String token;

  LoginDataModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }

}