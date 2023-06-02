import 'package:alekt_admin/domain/reading_task/word_source.dart';
import 'package:alekt_admin/models/Word.dart';
import 'package:flutter/material.dart';

typedef PartParcer = String Function(String part);

extension ToSource on Word {
  WordSource toSource(String textDk) => WordSource(
      dk: wordDK,
      eng: translateEng,
      urk: translateUkr,
      isTaskForInsert: wordDK.isTaskForInsert(textDk));
}

extension IsWrappedInBrackets on String {
  bool isTaskForInsert(String textDk) => textDk.contains("{{$this}}");
}

String toTranslate(String part) => "{${part}}";
String toInsertable(String part) => "{{${part}}}";

extension SelectedTextValidator on String {
  bool isValid(TextSelection offset, String source) {
    final pattern = RegExp(r'^[а-яА-ЯієїІЄЇa-zA-ZÆØÅæøå ,]+$');

    try {
      if (nearCurvedBracket(offset, source)) return false;

      if (!pattern.hasMatch(this)) {
        return false;
      }

      if (isStartBySpace && isEndBySpace) {
        return true;
      } else if (isStartBySpace) {
        return latterValidatorRight(offset, source);
      } else if (isEndBySpace) {
        return latterValidatorLeft(offset, source);
      }
    } catch (e) {
      return false;
    }

    try {
      return latterValidator(offset, source);
    } catch (e) {
      return false;
    }
  }

  bool spaceValidation(TextSelection offset, String source) {
    return (offset.textBefore(source).endsWith(" ") ||
            offset.textBefore(source).endsWith("  ")) &&
        (offset.textAfter(source).startsWith(" ") ||
            offset.textAfter(source).startsWith(" "));
  }

  bool latterValidator(TextSelection offset, String source) =>
      latterValidatorRight(offset, source) &&
      latterValidatorLeft(offset, source);

  bool isLatter(String lastSymbol) {
    final danishPattern = RegExp(r'[А-Яа-яa-zA-ZÆØÅæøå]');
    return !danishPattern.hasMatch(lastSymbol);
  }

  bool latterValidatorLeft(TextSelection offset, String source) =>
      isLatter(offset.textBefore(source).characters.last);

  bool latterValidatorRight(TextSelection offset, String source) =>
      isLatter(offset.textAfter(source).characters.first);

  bool get isEndBySpace => endsWith(" ") || endsWith("  ");
  bool get isStartBySpace => startsWith(" ") || startsWith("  ");
  bool nearCurvedBracket(TextSelection offset, String source) =>
      offset.textBefore(source).endsWith("{");
}

extension ToColoredSpan on String {
  List<String> get splitStringWithPatterns {
    List<String> result = [];

    String pattern = "";

    bool inPattern = false;

    for (String latter in characters) {
      if (inPattern && latter != "{" && latter != "}") {
        pattern += latter;
        continue;
      }

      if (!inPattern && latter != "{" && latter != "}") {
        result.add(latter);
        continue;
      }

      if (latter == "{") {
        inPattern = true;
        pattern += latter;
      }

      if (latter == "}" && !inPattern) {
        result.last = result.last + "}";
      }

      if (latter == "}" && inPattern) {
        inPattern = false;
        pattern += latter;
        result.add(pattern);
        pattern = "";
      }
    }

    return result;
  }

  TextSpan get toColoredSpan {
    final list = splitStringWithPatterns;

    return TextSpan(
      children: list.map(
        (e) {
          if (e.isWrappedInDoubleBraces) {
            return TextSpan(
                text: e, style: const TextStyle(color: Colors.blue));
          } else if (e.isWrappedInSingleBraces) {
            return TextSpan(
                text: e, style: const TextStyle(color: Colors.grey));
          } else {
            return TextSpan(text: e);
          }
        },
      ).toList(),
    );
  }

  bool get isWrappedInSingleBraces {
    var chapter = this;
    chapter.trim();
    return chapter.startsWith("{");
  }

  bool get isWrappedInDoubleBraces {
    var chapter = this;
    chapter.trim();
    return chapter.startsWith("{{");
  }
}
