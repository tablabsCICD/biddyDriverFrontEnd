import 'api_response.dart';

class MyModel {
  String id;
  String title;
  MyModel({required this.id, required this.title});

  factory MyModel.fromJson(Map<String, dynamic> json) {
    return MyModel(
      id: json["id"],
      title: json["title"],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": this.id,
    "title": this.title,
  };
}