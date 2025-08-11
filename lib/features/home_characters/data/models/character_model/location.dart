import 'package:hive/hive.dart';

part 'location.g.dart';

@HiveType(typeId: 1)
class Location extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? url;

  Location({this.name, this.url});

  factory Location.fromJson(Map<String, dynamic> json) =>
      Location(name: json['name'] as String?, url: json['url'] as String?);

  Map<String, dynamic> toJson() => {'name': name, 'url': url};
}
