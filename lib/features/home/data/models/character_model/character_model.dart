import 'package:hive/hive.dart';
import 'origin.dart';
import 'location.dart';

part 'character_model.g.dart';

@HiveType(typeId: 0)
class CharacterModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? status;

  @HiveField(3)
  String? species;

  @HiveField(4)
  String? type;

  @HiveField(5)
  String? gender;

  @HiveField(6)
  Origin? origin;

  @HiveField(7)
  Location? location;

  @HiveField(8)
  String? image;

  @HiveField(9)
  List<dynamic>? episode;

  @HiveField(10)
  String? url;

  @HiveField(11)
  DateTime? created;

  CharacterModel({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      status: json['status'] as String?,
      species: json['species'] as String?,
      type: json['type'] as String?,
      gender: json['gender'] as String?,
      origin: json['origin'] == null
          ? null
          : Origin.fromJson(json['origin'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      image: json['image'] as String?,
      episode: json['episode'] as List<dynamic>?,
      url: json['url'] as String?,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'status': status,
    'species': species,
    'type': type,
    'gender': gender,
    'origin': origin?.toJson(),
    'location': location?.toJson(),
    'image': image,
    'episode': episode,
    'url': url,
    'created': created?.toIso8601String(),
  };
}
