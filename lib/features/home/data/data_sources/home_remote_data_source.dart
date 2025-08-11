import 'package:rick_and_morty/core/networking/api_service.dart';
import 'package:rick_and_morty/features/home/data/models/character_model/character_model.dart';

class HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSource({required this.apiService});

  Future<List<CharacterModel>> fetchListOfCharacters({
    int pageNumber = 1,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  }) async {
    final queryParams = <String, dynamic>{
      'page': pageNumber,
      if (name != null && name.isNotEmpty) 'name': name,
      if (status != null && status.isNotEmpty) 'status': status,
      if (species != null && species.isNotEmpty) 'species': species,
      if (type != null && type.isNotEmpty) 'type': type,
      if (gender != null && gender.isNotEmpty) 'gender': gender,
    };
    var result = await apiService.get(
      endPoint: 'character/',
      queryParams: queryParams,
    );
    List<CharacterModel> books = getCharactersList(result);
    return books;
  }

  List<CharacterModel> getCharactersList(Map<String, dynamic> result) {
    List<CharacterModel> characters = [];
    for (var charcter in result['results']) {
      characters.add(CharacterModel.fromJson(charcter));
    }
    return characters;
  }
}
