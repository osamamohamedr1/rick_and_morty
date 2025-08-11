import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/utils/errors.dart';
import 'package:rick_and_morty/features/home_characters/data/models/character_model/character_model.dart';
import 'package:rick_and_morty/features/home_characters/domain/repos/home_repo.dart';

class HomeGetCharactersUseCase {
  final HomeRepo homeRepo;

  HomeGetCharactersUseCase(this.homeRepo);

  Future<Either<Failure, List<CharacterModel>>> call({
    int pageNumber = 1,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  }) async {
    return homeRepo.featchCharacters(
      pageNumber: pageNumber,
      name: name,
      status: status,
      species: species,
      type: type,
      gender: gender,
    );
  }
}
