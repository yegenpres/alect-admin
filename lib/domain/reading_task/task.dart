import 'package:alekt_admin/domain/reading_task/word_source.dart';
import 'package:alekt_admin/models/Level.dart';
import 'package:alekt_admin/models/ReadingTask.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum Status {
  data,
  loading,
  tryAgain,
  newTask,
  error,
  errorGPTChat;

  bool get isData => this == Status.data;
  bool get isLoading => this == Status.loading;
  bool get isTryAgain => this == Status.tryAgain;
  bool get isError => this == Status.error;
  bool get isNewTask => this == Status.newTask;
  bool get isGPTerror => this == Status.errorGPTChat;
}

@immutable
class ReadingTaskState extends Equatable {
  final List<({ReadingTask task, bool isNew})> allTasks;
  final String book, chapter, url, textDk, textEng, textUkr;
  final List<WordSource> createdWords;
  final Level level;
  final Status status;
  final String currentId;
  final String errorMessage;

  const ReadingTaskState({
    textEng = "",
    textUkr = "",
    textDk = "",
    this.status = Status.data,
    this.book = "",
    this.chapter = "",
    this.url = "",
    this.createdWords = const [],
    required this.level,
    this.currentId = "",
    this.allTasks = const [],
    this.errorMessage = '',
  })  : textUkr = " $textUkr ",
        textEng = " $textEng ",
        textDk = " $textDk ";

  const ReadingTaskState.test({
    this.textEng = " Jakob words in company, franchs restaurans. He is a cock.",
    this.textUkr = " Якоб працює у фірмі, французькому ресторані. Він повар.",
    this.book = "",
    this.chapter = "",
    this.status = Status.data,
    this.url = "",
    this.textDk =
        " Jacob arbejder på en fin, fransk restaurant. Her er han kok.",
    this.createdWords = const [],
    this.level = Level.A1,
    this.currentId = "",
    this.allTasks = const [],
    this.errorMessage = '',
  });

  ReadingTaskState copyWith({
    String? book,
    chapter,
    url,
    textDk,
    textEng,
    textUkr,
    List<WordSource>? createdWords,
    Level? level,
    Status? status,
    String? currentId,
    bool? isNewTask,
    List<({ReadingTask task, bool isNew})>? allTasks,
    String? errorMessage,
  }) =>
      ReadingTaskState(
        textUkr: textUkr ?? this.textUkr,
        textEng: textEng ?? this.textEng,
        textDk: textDk ?? this.textDk,
        chapter: chapter ?? this.chapter,
        url: url ?? this.url,
        book: book ?? this.book,
        createdWords: createdWords ?? this.createdWords,
        level: level ?? this.level,
        status: status ?? this.status,
        allTasks: allTasks ?? this.allTasks,
        currentId: currentId ?? this.currentId,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object> get props => [
        status,
        book,
        chapter,
        url,
        textDk,
        createdWords,
        textEng,
        textUkr,
        level,
        currentId,
        errorMessage,
      ];
}
