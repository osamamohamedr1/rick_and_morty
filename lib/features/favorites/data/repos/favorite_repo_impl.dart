import 'package:hive/hive.dart';
import 'package:rick_and_morty/core/utils/const.dart';
import 'package:rick_and_morty/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:rick_and_morty/features/home/data/models/character_model/character_model.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final _favoriteBox = Hive.box<CharacterModel>(kFavoriteBox);

  @override
  Future<void> addToFavorites(CharacterModel character) async {
    await _favoriteBox.put(character.id, character);
  }

  @override
  Future<List<CharacterModel>> getFavorites() async {
    return _favoriteBox.values.toList();
  }

  @override
  Future<void> removeFromFavorites(int characterId) async {
    await _favoriteBox.delete(characterId);
  }

  @override
  bool isFavorite(int characterId) {
    return _favoriteBox.containsKey(characterId);
  }
}
