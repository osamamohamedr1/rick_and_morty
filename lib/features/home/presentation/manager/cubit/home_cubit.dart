import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/core/services/connectivity_service.dart';
import 'package:rick_and_morty/features/home/data/models/character_model/character_model.dart';
import 'package:rick_and_morty/features/home/domain/use_case/home_use_case.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeGetCharactersUseCase) : super(HomeInitial());
  final HomeGetCharactersUseCase homeGetCharactersUseCase;

  List<CharacterModel> _characters = [];
  String? _currentName;
  String? _currentStatus;
  String? _currentSpecies;
  String? _currentType;
  String? _currentGender;

  Future<void> getCharactersList({
    int pageNumber = 1,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  }) async {
    bool isNewSearch =
        pageNumber == 1 ||
        name != _currentName ||
        status != _currentStatus ||
        species != _currentSpecies ||
        type != _currentType ||
        gender != _currentGender;

    if (isNewSearch) {
      emit(GetCharactersLoading());
      _characters.clear();
      _currentName = name;
      _currentStatus = status;
      _currentSpecies = species;
      _currentType = type;
      _currentGender = gender;
    } else {
      emit(GetCharactersPaginationLoading());
    }

    var result = await homeGetCharactersUseCase.call(
      pageNumber: pageNumber,
      name: name,
      status: status,
      species: species,
      type: type,
      gender: gender,
    );

    result.fold(
      (failure) {
        if (pageNumber == 1) {
          emit(GetCharactersFailure(failure.errorMessage));
        } else {
          emit(GetCharactersPaginationFailure(failure.errorMessage));
        }
      },
      (newCharacters) async {
        // Check if we're offline to show cache indicator
        final hasInternet = await ConnectivityService.hasInternetConnection();
        final isFromCache = !hasInternet;

        if (isNewSearch) {
          _characters = newCharacters;
        } else {
          final ids = _characters.map((character) => character.id).toSet();
          final filtered = newCharacters
              .where((character) => !ids.contains(character.id))
              .toList();
          _characters.addAll(filtered);
        }
        emit(GetCharactersSuccess(_characters, isFromCache: isFromCache));
      },
    );
  }
}
