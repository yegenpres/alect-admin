import 'package:alekt_admin/domain/reading_task/block/reading_event.dart';
import 'package:alekt_admin/domain/reading_task/block/reading_task_block.dart';
import 'package:alekt_admin/domain/reading_task/extensions.dart';
import 'package:alekt_admin/domain/reading_task/reading_task_service.dart';
import 'package:alekt_admin/domain/reading_task/task.dart';
import 'package:alekt_admin/domain/reading_task/word_source.dart';
import 'package:alekt_admin/models/ReadingTask.dart';
import 'package:alekt_admin/reading_task_editor/created_words.dart';
import 'package:alekt_admin/reading_task_editor/selectable_text.dart';
import 'package:alekt_admin/reading_task_editor/word_editor.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadingTaskEditorPage extends StatefulWidget {
  final ({ReadingTask task, bool isNew}) currentTask;

  const ReadingTaskEditorPage({
    super.key,
    required this.currentTask,
  });

  @override
  State<ReadingTaskEditorPage> createState() => _ReadingTaskEditorPageState();
}

class _ReadingTaskEditorPageState extends State<ReadingTaskEditorPage> {
  var word = WordSource();

  SelectedOffset offsetDK = (start: 0, end: 0);
  SelectedOffset offsetUkr = (start: 0, end: 0);
  SelectedOffset offsetEng = (start: 0, end: 0);

  void Function(bool isTaskInsert) onCreateWord() {
    return (isTaskInsert) {
      word.isTaskForInsert = isTaskInsert;
      context.read<ReadingTaskBlock>().add(EventCreateWord(
            word,
            (eng: offsetEng, ukr: offsetUkr, dk: offsetDK),
          ));
      setState(() {
        word = WordSource();
        offsetDK = offsetDK.toZero;
        offsetUkr = offsetUkr.toZero;
        offsetEng = offsetEng.toZero;
      });
    };
  }

  @override
  void initState() {
    context
        .read<ReadingTaskBlock>()
        .add(EventChoseReadingTask(task: widget.currentTask));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Column(
        children: [
          BlocBuilder<ReadingTaskBlock, ReadingTaskState>(
            buildWhen: (prevTask, task) =>
                prevTask.textDk != task.textDk ||
                prevTask.textUkr != task.textUkr ||
                prevTask.textEng != task.textEng,
            builder: (context, task) {
              return Texts(
                onUkraineSelect: (urk, offset) {
                  setState(() {
                    offsetUkr = offset;
                    word.urk = urk;
                  });
                },
                onEnglishSelect: (eng, offset) {
                  setState(() {
                    offsetEng = offset;
                    word.eng = eng;
                  });
                },
                onDanishSelect: (dk, offset) {
                  setState(() {
                    offsetDK = offset;
                    word.dk = dk;
                  });
                },
                textDk: task.textDk.toColoredSpan,
                textEng: task.textEng.toColoredSpan,
                textUkr: task.textUkr.toColoredSpan,
              );
            },
          ),
          const Divider(),
        ],
      ),
      bottomBar: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 1,
            child: WordEditor(
              danish: word.dk,
              ukraine: word.urk,
              english: word.eng,
              engOnChange: (v) => setState(() {
                word.eng = v;
              }),
              ukrOnChange: (v) => setState(() {
                word.urk = v;
              }),
              onConfirm: onCreateWord(),
            ),
          ),
          const Expanded(
            flex: 2,
            child: CreatedWords(),
          ),
        ],
      ),
    );
  }
}
