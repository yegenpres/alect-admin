import 'package:alekt_admin/domain/reading_task/block/reading_event.dart';
import 'package:alekt_admin/domain/reading_task/block/reading_task_block.dart';
import 'package:alekt_admin/domain/reading_task/task.dart';
import 'package:alekt_admin/domain/reading_task/word_source.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' hide Color, Colors;
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatedWords extends StatefulWidget {
  const CreatedWords({super.key});

  @override
  State<CreatedWords> createState() => _CreatedWordsState();
}

class _CreatedWordsState extends State<CreatedWords> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadingTaskBlock, ReadingTaskState>(
      builder: (context, state) => Wrap(
        children: [
          for (var word in state.createdWords)
            WordWidget(
              word: word,
            )
        ],
      ),
    );
  }
}

class WordWidget extends StatelessWidget {
  final WordSource word;

  const WordWidget({Key? key, required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: FittedBox(
        fit: BoxFit.cover,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.5),
            color: word.isTaskForInsert ? Colors.blue : Colors.transparent,
          ),
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Text(word.dk),
              Text(word.eng),
              Text(word.urk),
              GestureDetector(
                onTap: () =>
                    context.read<ReadingTaskBlock>().add(EventDeleteWord(word)),
                child: const Icon(Icons.close_sharp),
              )
            ],
          ),
        ),
      ),
    );
  }
}
