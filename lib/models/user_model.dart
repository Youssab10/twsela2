
class UserModel{
  String ? name;
  String ? email;
  String ? phone;
  String ? uId;
  String ? address;
  String ? image;
  String ? type;


  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.address,
    this.type,
    this.image,
    });

  UserModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    uId=json['uId'];
    address=json['address'];
    image=json['image'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'address':address,
      'type':type,
      'image':image??" ",
    };
  }
}