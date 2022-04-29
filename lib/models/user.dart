import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String id;
  String title;
  String body;
  User({
    required this.id,
    required this.title,
    required this.body,
  });

  factory User.fromJson(Map<String, dynamic> map) => _$UserFromJson(map);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
