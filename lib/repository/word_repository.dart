import 'package:alekt_admin/domain/reading_task/word_source.dart';
import 'package:alekt_admin/models/ModelProvider.dart';
import 'package:alekt_admin/repository/server_functions.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class WordRepository {
  Future<bool> saveWord(WordSource wordSource, Level level,
      [String taskId = ""]) async {
    try {
      final audio = await ServerFunction.base64soundDK(word: wordSource.dk);

      final word = Word(
        translateEng: wordSource.eng.toLowerCase(),
        translateUkr: wordSource.urk.toLowerCase(),
        wordDK: wordSource.dk.toLowerCase(),
        level: level,
        soundPath: audio,
        taskId: taskId,
      );

      final request = ModelMutations.create(word);
      final response = await Amplify.API.mutate(request: request).response;

      final createdWord = response.data;
      if (createdWord == null) {
        safePrint('errors: ${response.errors}');
        throw "can not save word ${response.errors}";
      }
      safePrint('Mutation result: ${createdWord.wordDK}');

      return true;
    } on ApiException catch (e) {
      safePrint('Mutation failed: $e');
      return false;
    }
  }

  Future<void> deleteWord(String wordId) async {
    final request = ModelMutations.deleteById(
      Word.classType,
      ReadingTaskModelIdentifier(id: wordId),
    );

    final response = await Amplify.API.mutate(request: request).response;
    safePrint('Response: $response');
  }

  Future<void> deleteWordsAssociateToTask(String taskId) async {
    final words = await fetchWords(taskId);

    for (final word in words) {
      await deleteWord(word.id);
    }
  }

  Future<List<Word>> fetchWords(String taskId) async {
    try {
      final request =
          ModelQueries.list(Word.classType, where: Word.TASKID.eq(taskId));
      final response = await Amplify.API.query(request: request).response;

      final tasks = response.data?.items;
      if (tasks == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }

      final excludedNullList = tasks.whereType<Word>();
      return excludedNullList.toList();
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }
}
