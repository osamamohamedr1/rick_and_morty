import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty/core/functions/save_charchters_local.dart';
import 'package:rick_and_morty/core/utils/const.dart';
import 'package:rick_and_morty/core/utils/errors.dart';
import 'package:rick_and_morty/features/home/data/data_sources/home_local_data_source.dart';
import 'package:rick_and_morty/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:rick_and_morty/features/home/data/models/character_model/character_model.dart';
import 'package:rick_and_morty/features/home/domain/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRepoImpl({
    required this.homeRemoteDataSource,
    required this.homeLocalDataSource,
  });
  @override
  Future<Either<Failure, List<CharacterModel>>> featchCharacters({
    int pageNumber = 1,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  }) async {
    List<CharacterModel> books;
    try {
      books = await homeRemoteDataSource.fetchListOfCharacters(
        pageNumber: pageNumber,
        name: name,
        status: status,
        species: species,
        type: type,
        gender: gender,
      );
      if (pageNumber == 1) {
        await Hive.box<CharacterModel>(kCharacterBox).clear();
        saveCharactersLocal(books, kCharacterBox);
      }
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(errorMessage: 'Ops there was an error'));
      }
    }
  }
}
