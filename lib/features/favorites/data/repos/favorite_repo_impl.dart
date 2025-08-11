import 'package:hive/hive.dart';
import 'package:rick_and_morty/core/utils/const.dart';
import 'package:rick_and_morty/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:rick_and_morty/features/home_characters/data/models/character_model/character_model.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final _favoriteBox = Hive.box<CharacterModel>(kFavoriteBox);

  @override
  Future<void> addToFavorites(CharacterModel character) async {
    // Create a copy of the character to avoid HiveError when storing in different boxes
    final characterCopy = CharacterModel(
      id: character.id,
      name: character.name,
      status: character.status,
      species: character.species,
      type: character.type,
      gender: character.gender,
      origin: character.origin,
      location: character.location,
      image: character.image,
      episode: character.episode,
      url: character.url,
      created: character.created,
    );
    await _favoriteBox.put(character.id, characterCopy);
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
