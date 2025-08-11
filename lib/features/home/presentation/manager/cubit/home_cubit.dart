import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/features/home/data/models/character_model/character_model.dart';
import 'package:rick_and_morty/features/home/domain/use_case/home_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeGetCharactersUseCase) : super(HomeInitial());
  final HomeGetCharactersUseCase homeGetCharactersUseCase;

  List<CharacterModel> _characters = [];
  int _lastPageLoaded = 0;
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
    // Check if this is a new search/filter (reset if any parameter changed)
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
      _lastPageLoaded = 0;
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
      (newCharacters) {
        if (isNewSearch) {
          _characters = newCharacters;
        } else {
          // Prevent duplicates by id for pagination
          final ids = _characters.map((c) => c.id).toSet();
          final filtered = newCharacters
              .where((c) => !ids.contains(c.id))
              .toList();
          _characters.addAll(filtered);
        }
        _lastPageLoaded = pageNumber;
        emit(GetCharactersSuccess(List<CharacterModel>.from(_characters)));
      },
    );
  }

  List<CharacterModel> get characters => List.unmodifiable(_characters);
  int get lastPageLoaded => _lastPageLoaded;
}
