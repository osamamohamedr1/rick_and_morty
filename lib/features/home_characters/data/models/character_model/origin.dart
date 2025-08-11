import 'package:hive/hive.dart';

part 'origin.g.dart';

@HiveType(typeId: 2)
class Origin extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? url;

  Origin({this.name, this.url});

  factory Origin.fromJson(Map<String, dynamic> json) =>
      Origin(name: json['name'] as String?, url: json['url'] as String?);

  Map<String, dynamic> toJson() => {'name': name, 'url': url};
}
