import 'package:alekt_admin/domain/reading_task/word_source.dart';
import 'package:alekt_admin/reading_task_editor/selectable_text.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class WordEditor extends StatefulWidget {
  final String danish;
  final String ukraine;
  final String english;
  final void Function(bool isTaskInsert)? onConfirm;
  final void Function(String value) engOnChange;
  final void Function(String value) ukrOnChange;

  const WordEditor({
    super.key,
    required this.danish,
    required this.ukraine,
    required this.english,
    this.onConfirm,
    required this.engOnChange,
    required this.ukrOnChange,
  });

  @override
  State<WordEditor> createState() => _WordEditorState();
}

class _WordEditorState extends State<WordEditor> {
  final dkController = TextEditingController();
  final ukrController = TextEditingController();
  final engController = TextEditingController();

  bool isTaskInsert = false;

  bool isValid = false;

  void _clean() {
    dkController.text = "";
    ukrController.text = "";
    engController.text = "";
  }

  @override
  void initState() {
    dkController.text = widget.danish;
    ukrController.text = widget.ukraine;
    engController.text = widget.english;
    isValidInput();
    super.initState();
  }

  void isValidInput() => setState(() {
        isValid = dkController.text.isNotEmpty &&
            ukrController.text.isNotEmpty &&
            engController.text.isNotEmpty &&
            dkController.text !=
                SelectionError.illegalCharacterSelected.toString() &&
            engController.text !=
                SelectionError.illegalCharacterSelected.toString() &&
            engController.text !=
                SelectionError.illegalCharacterSelected.toString();
      });

  @override
  void didUpdateWidget(covariant WordEditor oldWidget) {
    if (oldWidget.danish != widget.danish) dkController.text = widget.danish;
    if (oldWidget.ukraine != widget.ukraine)
      ukrController.text = widget.ukraine;
    if (oldWidget.english != widget.english)
      engController.text = widget.english;
    isValidInput();

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              ToggleSwitch(
                checked: isTaskInsert,
                // activeColor: Colors.teal,
                // inactiveTrackColor: Colors.blue,
                onChanged: (val) {
                  setState(() {
                    isTaskInsert = val;
                  });
                },
              ),
              Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(isTaskInsert
                      ? "Task for insert word"
                      : "translate only")),
            ],
          ),
          InfoLabel(
            label: "Danish",
            child: Chip(
              text: Text(
                dkController.text,
                style: dkController.text ==
                        SelectionError.illegalCharacterSelected.toString()
                    ? TextStyle(color: Colors.red)
                    : const TextStyle(),
              ),
            ),
          ),
          InfoLabel(
            label: "English",
            child: TextFormBox(
              onSaved: (v) {
                print(v);
              },
              onChanged: (_) {
                isValidInput();
              },
              controller: engController,
              autovalidateMode: AutovalidateMode.always,
              validator: FormBuilderValidators.compose(
                [
                  FormBuilderValidators.required(),
                  (value) {
                    if (value ==
                        SelectionError.illegalCharacterSelected.toString()) {
                      engController.text = "";
                      return value;
                    }
                  }
                ],
              ),
            ),
          ),
          InfoLabel(
            label: "Ukraine",
            child: TextFormBox(
              controller: ukrController,
              onChanged: (_) {
                isValidInput();
              },
              autovalidateMode: AutovalidateMode.always,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                (value) {
                  if (value ==
                      SelectionError.illegalCharacterSelected.toString()) {
                    ukrController.text = "";
                    return value;
                  }
                }
              ]),
            ),
          ),
          Button(
            onPressed: isValid
                ? () {
                    widget.engOnChange(engController.text);
                    widget.ukrOnChange(ukrController.text);

                    widget.onConfirm!(isTaskInsert);
                    _clean();
                  }
                : null,
            child: const Text("Create"),
          )
        ],
      ),
    );
  }
}

extension ToWord on String {
  toWord() => WordSource(dk: this);
}
