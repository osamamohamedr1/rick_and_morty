import 'package:hive/hive.dart';
import 'package:rick_and_morty/core/utils/const.dart';
import 'package:rick_and_morty/features/home_characters/data/models/character_model/character_model.dart';

class HomeLocalDataSource {
  List<CharacterModel> fetchCharacters({int pageNumber = 1}) {
    final box = Hive.box<CharacterModel>(kCharacterBox);
    return box.values.toList();
  }

  void saveCharactersLocal(List<CharacterModel> books, String boxName) {
    Box<CharacterModel> box = Hive.box<CharacterModel>(boxName);
    box.addAll(books);
  }
}
