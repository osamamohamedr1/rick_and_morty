import 'package:hive/hive.dart';
import 'package:rick_and_morty/features/home_characters/data/models/character_model/character_model.dart';

void saveCharactersLocal(List<CharacterModel> books, String boxName) {
  Box<CharacterModel> box = Hive.box<CharacterModel>(boxName);
  box.addAll(books);
}
