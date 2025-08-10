import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/utils/errors.dart';
import 'package:rick_and_morty/features/home/data/models/character_model/character_model.dart';
import 'package:rick_and_morty/features/home/domain/repos/home_repo.dart';

class HomeGetCharactersUseCase {
  final HomeRepo homeRepo;

  HomeGetCharactersUseCase(this.homeRepo);

  Future<Either<Failure, List<CharacterModel>>> call({
    int pageNumber = 1,
  }) async {
    return homeRepo.featchCharacters(pageNumber: pageNumber);
  }
}
