import 'package:json_annotation/json_annotation.dart';

part 'check_in_json.dart';

@JsonSerializable()
class Check {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  Check({this.userId, this.id, this.title, this.completed});

  factory Check.fromJson(Map<String, dynamic> json) => _$CheckFromJson(json);

  Map<String, dynamic> toJson() => _$CheckToJson(this);
}
