import 'package:alekt_admin/domain/reading_task/block/reading_event.dart';
import 'package:alekt_admin/domain/reading_task/extensions.dart';
import 'package:alekt_admin/domain/reading_task/reading_task_service.dart';
import 'package:alekt_admin/domain/reading_task/task.dart';
import 'package:alekt_admin/domain/reading_task/word_source.dart';
import 'package:alekt_admin/models/ModelProvider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadingTaskBlock extends Bloc<EventReadingTask, ReadingTaskState> {
  final ReadingTaskService readingService;

  ReadingTaskBlock({required this.readingService})
      : super(const ReadingTaskState.test()) {
    on<EventCreateReadingEntry>(_setNewTask);
    on<EventCreateReadingEntryTryAgain>(_setNewTaskTryAgain);
    on<EventCreateWord>(_createWord);
    on<EventDeleteWord>(_deleteWord);
    on<EventSaveReadingTask>(_saveTask);
    on<EventFetchAllTasks>(_fetchAllTasks);
    on<EventChoseReadingTask>(_choseTask);
    on<EventDeleteReadingTask>(_deleteTask);
    on<EventFetchTranslation>(_fetchTranslation);
  }

  ReadingTaskState _proccessText(
          WordSource word, SelectedOffsets offset, PartParcer parcer) =>
      state.copyWith(
        textDk: offset.dk.isExcistOffset
            ? state.textDk
                .replaceRange(offset.dk.start, offset.dk.end, parcer(word.dk))
            : null,
        textEng: offset.eng.isExcistOffset
            ? state.textEng.replaceRange(
                offset.eng.start, offset.eng.end, parcer(word.eng))
            : null,
        textUkr: offset.ukr.isExcistOffset
            ? state.textUkr.replaceRange(
                offset.ukr.start, offset.ukr.end, parcer(word.urk))
            : null,
      );

  void _createWord(EventCreateWord event, Emitter<ReadingTaskState> emit) {
    ReadingTaskState newState = state.copyWith();

    if (event.word.isTaskForInsert) {
      newState = _proccessText(event.word, event.offset, toInsertable);
    } else {
      newState = _proccessText(event.word, event.offset, toTranslate);
    }

    final newSet = List<WordSource>.from(state.createdWords);
    newSet.add(event.word);
    newState = newState.copyWith(createdWords: newSet);

    emit(newState);
  }

  void _choseTask(
      EventChoseReadingTask event, Emitter<ReadingTaskState> emit) async {
    if (event.task.task.id == state.currentId) return;

    emit(state.copyWith(
      status: Status.loading,
      textDk: event.task.task.text,
      textUkr: '',
      textEng: '',
      book: event.task.task.book,
      chapter: event.task.task.chapter,
      level: event.task.task.level,
      url: event.task.task.soundPath,
      currentId: event.task.task.id,
      createdWords: [],
    ));

    var words = <Word>[];

    if (!event.task.isNew) {
      words = await readingService.fetchTasksWords(event.task.task.id);
    }

    emit(
      state.copyWith(
        status: Status.data,
        createdWords:
            words.map((e) => e.toSource(event.task.task.text)).toList(),
      ),
    );
  }

  void _fetchTranslation(
      EventFetchTranslation event, Emitter<ReadingTaskState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      final ukr = await readingService.translateToUkraine(state.textDk);
      final eng = await readingService.translateToEnglish(state.textDk);

      emit(
        state.copyWith(
          status: Status.data,
          textUkr: ukr,
          textEng: eng,
        ),
      );
    } catch (e) {
      print(e);
      emit(state.copyWith(
          status: Status.errorGPTChat, errorMessage: e.toString()));
    }
  }

  void _setNewTask(
      EventCreateReadingEntry event, Emitter<ReadingTaskState> emit) async {
    final newTask = ReadingTask(
      text: event.text,
      book: event.book,
      chapter: event.chapter,
      soundPath: event.url,
      level: event.level,
    );

    emit(state.copyWith(status: Status.loading));

    try {
      emit(
        state.copyWith(
            status: Status.data,
            allTasks: [(task: newTask, isNew: true), ...state.allTasks]),
      );
    } catch (e) {
      print("block _sent new task eror: $e");
      emit(state.copyWith(status: Status.error));
    }
  }

  void _setNewTaskTryAgain(EventCreateReadingEntryTryAgain event,
      Emitter<ReadingTaskState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      final ukr = await readingService.translateToUkraine(state.textDk);
      final eng = await readingService.translateToEnglish(state.textDk);

      emit(
        state.copyWith(textUkr: ukr, textEng: eng, status: Status.newTask),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), status: Status.error));
    }
  }

  void _deleteWord(EventDeleteWord event, Emitter<ReadingTaskState> emit) {
    ReadingTaskState newState = state.copyWith();

    ReadingTaskState deleteBrackets() => newState.copyWith(
          textDk:
              newState.textDk.replaceAll("{${event.word.dk}}", event.word.dk),
          textEng: newState.textEng
              .replaceAll("{${event.word.eng}}", event.word.eng),
          textUkr: newState.textUkr
              .replaceAll("{${event.word.urk}}", event.word.urk),
        );

    var list = state.createdWords;
    list.remove(event.word);

    newState = deleteBrackets();
    newState = deleteBrackets();

    emit(newState.copyWith(createdWords: list));
  }

  void _saveTask(EventSaveReadingTask _, Emitter<ReadingTaskState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));

      final task =
          state.allTasks.firstWhere((task) => task.task.id == state.currentId);

      if (task.isNew) {
        await readingService.saveTask(state);
      } else {
        await readingService.update(state);
      }

      final aldTasks = state.allTasks.where((task) => !task.isNew);

      emit(state.copyWith(
          status: Status.data,
          allTasks: [(isNew: false, task: task.task), ...aldTasks]));
    } catch (e) {
      print(e);
      emit(state.copyWith(errorMessage: e.toString(), status: Status.error));
    }
  }

  void _deleteTask(
      EventDeleteReadingTask _, Emitter<ReadingTaskState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      final isCreated = state.allTasks
          .firstWhere((element) => element.task.id == state.currentId);

      if (!isCreated.isNew) {
        await readingService.delete(state.currentId);
      }

      final newListTask =
          state.allTasks.where((element) => element.task.id != state.currentId);

      emit(ReadingTaskState(level: Level.A1, allTasks: newListTask.toList()));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), status: Status.error));
    }
  }

  void _fetchAllTasks(
      EventFetchAllTasks _, Emitter<ReadingTaskState> emit) async {
    try {
      final data = await readingService.fethcAllTasks();
      final tasks = data.map((e) => (task: e, isNew: false)).toList();
      emit(state.copyWith(allTasks: tasks));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), status: Status.error));
    }

    // for (final data in tasks) {
    //   readingService.delete(data.task.id);
    // }
  }
}
