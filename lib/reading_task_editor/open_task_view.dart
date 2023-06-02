import 'package:alekt_admin/domain/reading_task/block/reading_event.dart';
import 'package:alekt_admin/domain/reading_task/block/reading_task_block.dart';
import 'package:alekt_admin/models/Level.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:sizer/sizer.dart';

class OpenTaskView extends StatefulWidget {
  final void Function() close;

  const OpenTaskView({Key? key, required this.close}) : super(key: key);

  @override
  State<OpenTaskView> createState() => _OpenTaskViewState();
}

class _OpenTaskViewState extends State<OpenTaskView> {
  final _formKey = GlobalKey<FormState>();

  final _textController = TextEditingController();
  final _bookController = TextEditingController();
  final _chapterController = TextEditingController();
  final _urlController = TextEditingController();

  Level selectedLevel = Level.A1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PillButtonBar(
            selected: selectedLevel.index,
            onChanged: (i) => setState(() => selectedLevel = Level.values[i]),
            items: [
              for (var level in Level.values)
                PillButtonBarItem(text: Text(level.name)),
            ]),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  InfoLabel(
                    label: "Text",
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: SingleChildScrollView(
                        child: TextFormBox(
                          controller: _textController,
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.maxLength(2900,
                                  errorText: "Text is too long"),
                            ],
                          ),
                          expands: true,
                          minLines: null,
                          maxLines: null,
                          // maxLength: 2900,
                        ),
                      ),
                    ),
                  ),
                  InfoLabel(
                    label: "Book",
                    child: TextFormBox(
                      controller: _bookController,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                  ),
                  InfoLabel(
                    label: "Chapter",
                    child: TextFormBox(
                      controller: _chapterController,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                  ),
                  InfoLabel(
                    label: "SoundUrl",
                    child: TextFormBox(
                      controller: _urlController,
                      validator: FormBuilderValidators.url(),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  const Expanded(child: SizedBox()),
                  Button(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;
                        context
                            .read<ReadingTaskBlock>()
                            .add(EventCreateReadingEntry(
                              text: _textController.text
                                  .trim()
                                  .replaceAll("\n", "  "),
                              book: _bookController.text.trim(),
                              chapter: _chapterController.text.trim(),
                              url: _urlController.text.trim(),
                              level: selectedLevel,
                            ));
                        widget.close();
                      },
                      child: const Text("Submit")),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
