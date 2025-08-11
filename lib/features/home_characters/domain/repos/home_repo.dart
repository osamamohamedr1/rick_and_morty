import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/utils/errors.dart';
import 'package:rick_and_morty/features/home_characters/data/models/character_model/character_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<CharacterModel>>> featchCharacters({
    int pageNumber,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  });
}
