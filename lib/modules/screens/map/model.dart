class SearchData{
  late List<Result> results ;
  SearchData.fromJson(Map<String,dynamic>json){
    results = List.from(json['features']??[]).map((e) => Result.fromJson(e)).toList();
  }
}
class Result{
  late num lat,lng;
  late String name,label;
  Result.fromJson(Map<String,dynamic> json){
    lat = json['geometry']['coordinates'][1];
    lng = json['geometry']['coordinates'][0];
    name = json['properties']['name'];
    label = json['properties']['label'];
  }
}