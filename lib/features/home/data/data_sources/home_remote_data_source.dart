import 'package:rick_and_morty/core/functions/save_charchters_local.dart';
import 'package:rick_and_morty/core/networking/api_service.dart';
import 'package:rick_and_morty/core/utils/const.dart';
import 'package:rick_and_morty/features/home/data/models/character_model/character_model.dart';

class HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSource({required this.apiService});

  Future<List<CharacterModel>> fetchListOfCharacters({
    int pageNumber = 1,
  }) async {
    var result = await apiService.get(endPoint: 'character/?page=1');
    List<CharacterModel> books = getCharactersList(result);
    // saveCharactersLocal(books, kCharacterBox);
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
