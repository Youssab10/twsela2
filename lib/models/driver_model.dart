
class DriverModel{
  String ? name;
  String ? email;
  String ? phone;
  String ? uId;
  int ?buildingNumber;
  int ?transportYear;
  String ? street;
  String ? licenseNumber;
  String ? carType;
  String ? carModel;
  String ? carColor;
  String ? plateNumber;
  String ? image;
  String ? type;


  DriverModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.street,
    required this.type,
    required this.buildingNumber,
    required this.transportYear,
    required this.licenseNumber,
    required this.carType,
    required this.carColor,
    required this.carModel,
    required this.plateNumber,
    });

  DriverModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    uId=json['uId'];
    street=json['street'];
    image=json['image'];
    buildingNumber=json['buildingNumber'];
    transportYear=json['transportYear'];
    licenseNumber=json['licenseNumber'];
    carType=json['carType'];
    carModel=json['carModel'];
    carColor=json['carColor'];
    plateNumber=json['plateNumber'];
    type=json['type'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'street':street,
      'type':type,
      'buildingNumber':buildingNumber,
      'transportYear':transportYear,
      'licenseNumber':licenseNumber,
      'carType':carType,
      'carModel':carModel,
      'carColor':carColor,
      'plateNumber':plateNumber,
      'image':image??" ",
    };
  }
}