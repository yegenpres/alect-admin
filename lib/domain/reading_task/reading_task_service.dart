import 'dart:async';

import 'package:alekt_admin/domain/reading_task/task.dart';
import 'package:alekt_admin/models/ReadingTask.dart';
import 'package:alekt_admin/models/Word.dart';
import 'package:alekt_admin/repository/server_functions.dart';
import 'package:alekt_admin/repository/task_repository.dart';
import 'package:alekt_admin/repository/word_repository.dart';

const sourceText =
    "RESTAURANTEN. Jacob arbejder på en fin, fransk restaurant. Her er han kok .  Han arbejder hårdt . Hver dag lærer han nye ting . Han laver franske supper. Han laver frølår . Og han lærer alt om franske oste . Lavede du nye retter  i går? spørger Lone. Nej, men jeg smagte en dyr vin . Den koster over 2000 kr. Det er en god vin. Vil du smage ? Jeg har lidt med hjem. Nej, tak. siger Lone. Så går hun ind i stuen igen. ";

typedef SelectedOffset = ({int start, int end});

extension ToZeroOffset on SelectedOffset {
  SelectedOffset get toZero => (start: 0, end: 0);
}

class ReadingTaskService {
  static Future<bool> isTimeOut = Future.value(true);

  final WordRepository wordRepository;
  final TaskRepository taskRepository;

  ReadingTaskService({
    required this.wordRepository,
    required this.taskRepository,
  });

  Future saveTask(ReadingTaskState task) async {
    await taskRepository.saveTask(task);
  }

  Future delete(String taskId) async {
    await taskRepository.deleteTask(taskId);
    await wordRepository.deleteWordsAssociateToTask(taskId);
  }

  Future update(ReadingTaskState task) async {
    await delete(task.currentId);

    await saveTask(task);
  }

  Future<String> _translate(String textDK) async {
    await isTimeOut;

    final message = await ServerFunction.askGPT(text: textDK);

    isTimeOut = Future.delayed(const Duration(seconds: 15), () => true);

    return message;
  }

  Future<String> translateToEnglish(String textDK) async =>
      await _translate("Translate this text to English: $textDK");
  Future<String> translateToUkraine(String textDK) async =>
      await _translate("Translate this text to Ukraine: $textDK");

  Future<List<ReadingTask>> fethcAllTasks() async =>
      await taskRepository.fetchAll();

  Future<List<Word>> fetchTasksWords(String taskId) async =>
      await wordRepository.fetchWords(taskId);
}
