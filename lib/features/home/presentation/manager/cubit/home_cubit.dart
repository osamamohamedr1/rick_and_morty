import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/features/home/data/models/character_model/character_model.dart';
import 'package:rick_and_morty/features/home/domain/use_case/home_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeGetCharactersUseCase) : super(HomeInitial());
  final HomeGetCharactersUseCase homeGetCharactersUseCase;
  Future<void> getCharactersList({int pageNumber = 1}) async {
    // pageNumber == 1
    //     ? emit(GetCharactersLoading())
    //     : emit(GetCharactersPaginationLoading());

    emit(GetCharactersLoading());
    var result = await homeGetCharactersUseCase.call(pageNumber: pageNumber);
    result.fold(
      (failure) => emit(GetCharactersFailure(failure.errorMessage)),
      //  pageNumber == 1
      //     ? emit(GetCharactersFailure(failure.errorMessage))
      //     : emit(GetCharactersPaginationFailure(failure.errorMessage)),
      (books) => emit(GetCharactersSuccess(books)),
    );
  }
}
