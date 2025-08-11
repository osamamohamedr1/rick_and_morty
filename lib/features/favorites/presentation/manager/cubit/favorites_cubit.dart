import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:rick_and_morty/features/home/data/models/character_model/character_model.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this.favoriteRepository) : super(FavoritesInitial());
  final FavoriteRepository favoriteRepository;
  Future<void> addFavorite(CharacterModel character) async {
    await favoriteRepository.addToFavorites(character);
    await loadFavorites();
  }

  Future<void> removeFavorite(int characterId) async {
    await favoriteRepository.removeFromFavorites(characterId);
    await loadFavorites();
  }

  bool checkFavorite(int characterId) {
    return favoriteRepository.isFavorite(characterId);
  }

  Future<void> loadFavorites() async {
    emit(FavoritesInitial());
    final favorites = await favoriteRepository.getFavorites();
    emit(FavoritesListLoaded(favorites));
  }
}
