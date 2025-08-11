part of 'favorites_cubit.dart';

@immutable
sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesChanged extends FavoritesState {
  final int characterId;
  final bool isFavorite;

  FavoritesChanged(this.characterId, this.isFavorite);
}

final class FavoritesListLoaded extends FavoritesState {
  final List favorites;
  FavoritesListLoaded(this.favorites);
}
