
class TripModel{
  String ? driverName;
  String ? date;
  String ? time;
  String ? driverUId;
  String ? from;
  String ? to;
  String ? price;
  String ? passengersNumbers;
  String ? passengersNumbersLogin;
  String ? tripCode;
  String ? status;
  String ? id;
  bool ? isApplied;


  TripModel({
    required this.driverName,
    required this.date,
    required this.time,
    required this.driverUId,
    required this.from,
    required this.price,
    required this.passengersNumbers,
    required this.passengersNumbersLogin,
    required this.tripCode,
    required this.status,
    required this.to,
    this.isApplied,
    required this.id,
  });

  TripModel.fromJson(Map<String,dynamic>json){
    driverName=json['driverName'];
    date=json['date'];
    time=json['time'];
    driverUId=json['driverUId'];
    from=json['from'];
    to=json['to'];
    price=json['price'];
    status=json['status'];
    id=json['id'];
    tripCode=json['tripCode'];
    passengersNumbers=json['passengersNumbers'];
    passengersNumbersLogin=json['passengersNumbersLogin'];
  }

  Map<String,dynamic> toMap(){
    return {
      'driverName':driverName,
      'date':date,
      'time':time,
      'driverUId':driverUId,
      'from':from,
      'id':id,
      'price':price,
      'passengersNumbers':passengersNumbers,
      'passengersNumbersLogin':passengersNumbersLogin,
      'tripCode':tripCode,
      'status':status,
      'to':to??" ",
    };
  }
}