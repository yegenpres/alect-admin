import 'package:alekt_admin/domain/reading_task/block/reading_event.dart';
import 'package:alekt_admin/domain/reading_task/block/reading_task_block.dart';
import 'package:alekt_admin/domain/reading_task/extensions.dart';
import 'package:alekt_admin/domain/reading_task/reading_task_service.dart';
import 'package:alekt_admin/domain/reading_task/task.dart';
import 'package:fluent_ui/fluent_ui.dart' as fl;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

enum SelectionError {
  illegalCharacterSelected;
}

class Texts extends StatelessWidget {
  final void Function(String, SelectedOffset) onUkraineSelect;
  final void Function(String, SelectedOffset) onEnglishSelect;
  final void Function(String, SelectedOffset) onDanishSelect;
  final TextSpan textDk;
  final TextSpan textEng;
  final TextSpan textUkr;

  const Texts({
    super.key,
    required this.onUkraineSelect,
    required this.onEnglishSelect,
    required this.onDanishSelect,
    required this.textDk,
    required this.textEng,
    required this.textUkr,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          BlocBuilder<ReadingTaskBlock, ReadingTaskState>(
              builder: (context, task) {
            if (task.status.isGPTerror) {
              return Center(
                child: Column(
                  children: [
                    const Text("Some error with chatGPT"),
                    Text(task.errorMessage),
                    SizedBox(
                      height: 20.h,
                    ),
                    fl.Button(
                        child: const Text("Try again"),
                        onPressed: () => context
                            .read<ReadingTaskBlock>()
                            .add(EventFetchTranslation())),
                  ],
                ),
              );
            } else if (task.status.isLoading) {
              return const Padding(
                padding: EdgeInsets.all(30),
                child:
                    SizedBox(height: 200, width: 200, child: fl.ProgressBar()),
              );
            } else if (task.textUkr.trim().isEmpty ||
                task.textEng.trim().isEmpty) {
              return Center(
                child: Column(
                  children: [
                    const Text("Translate text"),
                    SizedBox(
                      height: 5.h,
                    ),
                    fl.Button(
                      onPressed: () => context
                          .read<ReadingTaskBlock>()
                          .add(EventFetchTranslation()),
                      child: const Text("Translate!"),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ],
                ),
              );
            } else {
              return Column(
                children: [
                  TextSelectorWidget.translated(
                    title: "Ukraine",
                    onValueChange: onUkraineSelect,
                    sourceText: textUkr,
                  ),
                  TextSelectorWidget.translated(
                    title: "English",
                    onValueChange: onEnglishSelect,
                    sourceText: textEng,
                  ),
                ],
              );
            }
          }),
          TextSelectorWidget.origin(
            onValueChange: onDanishSelect,
            sourceText: textDk,
          )
        ],
      ),
    );
  }
}

class TextSelectorWidget extends StatefulWidget {
  final String title;
  final bool _isOrigin;
  final TextSpan sourceText;

  final void Function(String, SelectedOffset) onValueChange;

  const TextSelectorWidget.origin({
    super.key,
    required this.onValueChange,
    required this.sourceText,
  })  : title = "Dansk",
        _isOrigin = true;

  const TextSelectorWidget.translated({
    super.key,
    required this.onValueChange,
    required this.sourceText,
    required this.title,
  }) : _isOrigin = false;

  @override
  State<TextSelectorWidget> createState() => _TextSelectorWidgetState();
}

class _TextSelectorWidgetState extends State<TextSelectorWidget> {
  String selectedText = "";
  bool isValid = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 20),
            ),
            Theme(
              data: ThemeData(
                  textSelectionTheme: isValid
                      ? const TextSelectionThemeData()
                      : const TextSelectionThemeData(
                          selectionColor: Colors.deepOrangeAccent)),
              child: SelectableText.rich(
                TextSpan(children: [widget.sourceText]),
                onTap: () {
                  widget.onValueChange(
                    SelectionError.illegalCharacterSelected.toString(),
                    (start: 0, end: 0),
                  );
                },
                onSelectionChanged: (selected, _) {
                  final text =
                      selected.textInside(widget.sourceText.toPlainText()!);
                  final offset = (start: selected.start, end: selected.end);

                  isValid =
                      text.isValid(selected, widget.sourceText.toPlainText()!);
                  selectedText = text
                    ..trim()
                    ..toLowerCase();

                  if (isValid) {
                    widget.onValueChange(text, offset);
                  } else {
                    widget.onValueChange(
                        SelectionError.illegalCharacterSelected.toString(),
                        offset);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
