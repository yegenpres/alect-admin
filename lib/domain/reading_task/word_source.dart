import 'package:alekt_admin/models/Level.dart';
import 'package:alekt_admin/models/Word.dart';
import 'package:alekt_admin/reading_task_editor/selectable_text.dart';

class WordSource {
  String dk;
  String urk;
  String eng;

  bool isTaskForInsert;

  WordSource(
      {this.dk = "",
      this.urk = "",
      this.eng = "",
      this.isTaskForInsert = false});

  WordSource copy(
          {String? dk, String? urk, String? eng, bool? isTaskForInsert}) =>
      WordSource(
          dk: dk ?? this.dk,
          urk: urk ?? this.urk,
          eng: eng ?? this.eng,
          isTaskForInsert: isTaskForInsert ?? this.isTaskForInsert);

  bool isValid() =>
      dk.isNotEmpty &&
      urk.isNotEmpty &&
      eng.isNotEmpty &&
      dk != SelectionError.illegalCharacterSelected.toString() &&
      eng != SelectionError.illegalCharacterSelected.toString() &&
      urk != SelectionError.illegalCharacterSelected.toString();

  @override
  List<Object> get props => [dk, urk, eng, isTaskForInsert];

  @override
  String toString() =>
      "{dk: $dk, url: $urk, url: $urk, isTask: $isTaskForInsert}";
}

extension ToWord on Word {
  WordSource toWord(Level level) =>
      WordSource(dk: wordDK, urk: translateUkr, eng: translateEng);
}
