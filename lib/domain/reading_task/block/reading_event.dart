import 'package:alekt_admin/domain/reading_task/reading_task_service.dart';
import 'package:alekt_admin/domain/reading_task/word_source.dart';
import 'package:alekt_admin/models/Level.dart';
import 'package:alekt_admin/models/ReadingTask.dart';

typedef SelectedOffsets = ({
  SelectedOffset dk,
  SelectedOffset ukr,
  SelectedOffset eng
});

extension isExcist on SelectedOffset {
  bool get isExcistOffset => this.end != 0 && this.start != 0;
}

sealed class EventReadingTask {
  EventReadingTask() {
    print(this);
  }
}

final class EventCreateWord extends EventReadingTask {
  final WordSource word;
  final SelectedOffsets offset;

  EventCreateWord(this.word, this.offset);
}

final class EventDeleteWord extends EventReadingTask {
  final WordSource word;

  EventDeleteWord(this.word);
}

final class EventCreateReadingEntry extends EventReadingTask {
  final String book, chapter, url, text;
  final Level level;

  EventCreateReadingEntry({
    required this.book,
    required this.chapter,
    required this.url,
    required this.text,
    required this.level,
  });
}

final class EventSaveReadingTask extends EventReadingTask {}

final class EventUpdateReadingTask extends EventReadingTask {}

final class EventDeleteReadingTask extends EventReadingTask {}

final class EventChoseReadingTask extends EventReadingTask {
  final ({ReadingTask task, bool isNew}) task;

  EventChoseReadingTask({required this.task});
}

final class EventFetchTranslation extends EventReadingTask {}

final class EventFetchAllTasks extends EventReadingTask {}

final class EventCreateReadingEntryTryAgain extends EventReadingTask {}
