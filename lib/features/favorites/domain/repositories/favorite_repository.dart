import 'package:rick_and_morty/features/home_characters/data/models/character_model/character_model.dart';

abstract class FavoriteRepository {
  Future<void> addToFavorites(CharacterModel character);
  Future<List<CharacterModel>> getFavorites();
  Future<void> removeFromFavorites(int characterId);
  bool isFavorite(int characterId);
}
