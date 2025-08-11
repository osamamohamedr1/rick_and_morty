import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
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
    int pageNumber = 0,
  }) async {
    List<CharacterModel> books;
    try {
      // books = homeLocalDataSource.fetchCharacters(pageNumber: pageNumber);
      // if (books.isNotEmpty) {
      //   return right(books);
      // }
      books = await homeRemoteDataSource.fetchListOfCharacters(
        pageNumber: pageNumber,
      );
      return right(books);
    } catch (e) {
      print(e.toString());
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      //  else if (e is HiveError || e is TypeError || e is FileSystemException) {
      //   return left(HiveFailure.fromHiveError(e));
      // }
      else {
        return left(ServerFailure(errorMessage: 'Ops there was an error'));
      }
    }
  }
}
