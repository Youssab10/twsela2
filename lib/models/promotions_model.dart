
class PromotionsModel{
  String ? id;
  String ? condition;
  String ? discount;


  PromotionsModel({
    required this.id,
    required this.condition,
    required this.discount,

  });

  PromotionsModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    condition=json['condition'];
    discount=json['discount'];

  }

  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'condition':condition,
      'discount':discount,

    };
  }
}