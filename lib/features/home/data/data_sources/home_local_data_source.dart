import 'package:hive/hive.dart';
import 'package:rick_and_morty/core/utils/const.dart';
import 'package:rick_and_morty/features/home/data/models/character_model/character_model.dart';

class HomeLocalDataSource {
  /// Fetch cached characters for a specific API page (1-based index).
  /// Each page contains 20 characters.
  List<CharacterModel> fetchCharacters({int pageNumber = 1}) {
    final box = Hive.box<CharacterModel>(kCharacterBox);

    // Calculate the range of items for the given page
    final startIndex = (pageNumber - 1) * 20;
    final endIndex = startIndex + 20;

    // If the start index exceeds stored items, no data is available
    if (startIndex >= box.length) {
      return [];
    }

    // Clamp the end index to the total number of stored characters
    final clampedEndIndex = endIndex.clamp(0, box.length);

    return box.values.toList().sublist(startIndex, clampedEndIndex);
  }
}
