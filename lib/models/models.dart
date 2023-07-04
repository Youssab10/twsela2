


class OnBoardingItem{
  String image;
  String title;
  String body;

  OnBoardingItem({
   required this.image,
   required this.body,
   required this.title,
});
}


class ShopLoginModel{
  late bool status;
  String ? message ;
  UserData ? data;

  ShopLoginModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    message= json['message'] != null ? json['message'] : null;
    data=json['data'] != null ? UserData.fromJson(json['data']) : null ;
  }
}


class UserData{
 late int id;
 late String name ;
 late String email ;
 late String phone ;
 late String image ;
 late String token ;


  UserData.fromJson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    email=json['email'];
    image=json['image'];
    token=json['token'];
    phone=json['phone'];
  }

}


