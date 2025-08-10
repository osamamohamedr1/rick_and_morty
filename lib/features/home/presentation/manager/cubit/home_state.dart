part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetCharactersLoading extends HomeState {}

final class GetCharactersSuccess extends HomeState {
  final List<CharacterModel> books;

  GetCharactersSuccess(this.books);
}

final class GetCharactersPaginationLoading extends HomeState {}

final class GetCharactersPaginationFailure extends HomeState {
  final String message;

  GetCharactersPaginationFailure(this.message);
}

final class GetCharactersFailure extends HomeState {
  final String message;

  GetCharactersFailure(this.message);
}
