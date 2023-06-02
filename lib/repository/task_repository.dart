import 'package:alekt_admin/domain/reading_task/task.dart';
import 'package:alekt_admin/models/ReadingTask.dart';
import 'package:alekt_admin/models/Word.dart';
import 'package:alekt_admin/repository/server_functions.dart';
import 'package:alekt_admin/repository/word_repository.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class SaveTaskResult {}

class TaskRepository {
  final WordRepository wordRepo;

  TaskRepository({required this.wordRepo});

  Future<(ReadingTask, List<Word>)> _constructTask(
      ReadingTaskState taskSource) async {
    String link = taskSource.url;

    Future<String> linkTask = Future.value("");

    if (link.isEmpty) {
      linkTask = ServerFunction.saveDKSound(
        text: taskSource.textDk,
        path: "${taskSource.book} ${taskSource.chapter}".replaceAll(" ", "_"),
      ).then((value) => link = value);
    }

    final soundsBase64 = <String, String>{};
    final wordSoundTask = <Future>[];

    for (final wordSource in taskSource.createdWords) {
      final task = ServerFunction.base64soundDK(word: wordSource.dk)
          .then((value) => soundsBase64[wordSource.dk] = value);
      wordSoundTask.add(task);
    }

    await Future.wait([
      ...wordSoundTask,
      if (link.isEmpty) linkTask,
    ]);

    if (taskSource.createdWords.length != soundsBase64.length)
      throw "list createdWords and list soundbase64 has diferent length";

    List<Word> words = [];

    final task = ReadingTask(
      text: taskSource.textDk,
      book: taskSource.book,
      chapter: taskSource.chapter,
      soundPath: link,
      level: taskSource.level,
    );

    for (var i = 0; i < taskSource.createdWords.length; i++) {
      words.add(
        Word(
            translateEng: taskSource.createdWords[i].eng,
            translateUkr: taskSource.createdWords[i].urk,
            wordDK: taskSource.createdWords[i].dk,
            level: taskSource.level,
            soundPath: soundsBase64[taskSource.createdWords[i].dk]!,
            taskId: task.id),
      );
    }

    return (task, words);
  }

  Future<bool> saveTask(ReadingTaskState taskSource) async {
    try {
      final (task, words) = await _constructTask(taskSource);

      final request = ModelMutations.create(task);
      final response = await Amplify.API.mutate(request: request).response;

      final createdTask = response.data;
      if (createdTask == null) {
        safePrint('errors: ${response.errors}');
        throw "can not save word ${response.errors}";
      }
      safePrint('Mutation result create: ${createdTask.chapter}');

      await _saveWords(words);

      return true;
    } on ApiException catch (e) {
      safePrint('Mutation failed create: $e');
      return false;
    }
  }

  Future<List<ReadingTask>> fetchAll() async {
    try {
      final request = ModelQueries.list(ReadingTask.classType);
      final response = await Amplify.API.query(request: request).response;

      final tasks = response.data?.items;
      if (tasks == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }

      final excludedNullList = tasks.whereType<ReadingTask>();
      print(excludedNullList);
      return excludedNullList.toList();
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  Future<void> deleteTask(String taskId) async {
    final request = ModelMutations.deleteById(
      ReadingTask.classType,
      ReadingTaskModelIdentifier(id: taskId),
    );

    final response = await Amplify.API.mutate(request: request).response;
    safePrint('Response: $response');
  }

  Future _saveWords(List<Word> words) async {
    for (final word in words) {
      final request = ModelMutations.create(word);
      final response = await Amplify.API.mutate(request: request).response;

      final createdWord = response.data;
      if (createdWord == null) {
        safePrint('errors: ${response.errors}');
        throw "can not save word ${response.errors}";
      }
      safePrint('Mutation result: ${createdWord.wordDK}');
    }
  }
}
