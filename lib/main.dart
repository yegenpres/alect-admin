import 'package:alekt_admin/amplifyconfiguration.dart';
import 'package:alekt_admin/domain/reading_task/block/reading_event.dart';
import 'package:alekt_admin/domain/reading_task/block/reading_task_block.dart';
import 'package:alekt_admin/domain/reading_task/reading_task_service.dart';
import 'package:alekt_admin/domain/reading_task/task.dart';
import 'package:alekt_admin/models/ModelProvider.dart';
import 'package:alekt_admin/reading_task_editor/open_task_view.dart';
import 'package:alekt_admin/reading_task_editor/reading_task_edito_page.dart';
import 'package:alekt_admin/repository/server_functions.dart';
import 'package:alekt_admin/repository/task_repository.dart';
import 'package:alekt_admin/repository/word_repository.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:equatable/equatable.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:system_theme/system_theme.dart';

void main() {
  EquatableConfig.stringify = true;

  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider<ReadingTaskService>(
              create: (context) {
                final wordRepo = WordRepository();
                return ReadingTaskService(
                  wordRepository: wordRepo,
                  taskRepository: TaskRepository(wordRepo: wordRepo),
                );
              },
            ),
          ],
          child: Builder(builder: (context) {
            return BlocProvider(
                create: (_) => ReadingTaskBlock(
                    readingService: context.watch<ReadingTaskService>()),
                child: const MyApp());
          }),
        );
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Flutter Demo',
      theme: FluentThemeData(
          accentColor: SystemTheme.accentColor.accent.toAccentColor()),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late OverlayEntry _createTaskEverlay;
  late OverlayEntry _errorOverlay;
  late OverlayEntry _confirmDeleteOverlay;

  int index = 0;

  OverlayEntry createOverlayEntry() {
    return OverlayEntry(
      builder: (context) {
        return ContentDialog(
          content: OpenTaskView(
            close: () {
              _createTaskEverlay.remove();
            },
          ),
          actions: [
            Button(
              child: const Text("Close"),
              onPressed: () => _createTaskEverlay.remove(),
            )
          ],
        );
      },
    );
  }

  OverlayEntry createErrorOverlay() {
    return OverlayEntry(
      builder: (context) {
        return ContentDialog(
          content: Text("error"),
          actions: [
            Button(
              child: BlocBuilder<ReadingTaskBlock, ReadingTaskState>(
                  builder: (_, state) => Wrap(
                        children: [Text(state.errorMessage)],
                      )),
              onPressed: () => _errorOverlay.remove(),
            )
          ],
        );
      },
    );
  }

  OverlayEntry createConfirmDeleteOverlay() {
    return OverlayEntry(
      builder: (context) {
        return BlocBuilder<ReadingTaskBlock, ReadingTaskState>(
          builder: (context, state) => ContentDialog(
            content: Text("delete ${state.book} ${state.chapter} ?"),
            actions: [
              Button(
                child: Text("No"),
                onPressed: () => _confirmDeleteOverlay.remove(),
              ),
              Button(
                child: Text("Yes"),
                onPressed: () {
                  context
                      .read<ReadingTaskBlock>()
                      .add(EventDeleteReadingTask());
                  _confirmDeleteOverlay.remove();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    _createTaskEverlay = createOverlayEntry();
    _errorOverlay = createErrorOverlay();
    _confirmDeleteOverlay = createConfirmDeleteOverlay();

    _configureAmplify(context).then((_) async {
      try {
        final res = await ServerFunction.askGPT(text: "hi chat");
        print(res);
        context.read<ReadingTaskBlock>().add(EventFetchAllTasks());
      } on ApiException catch (e) {
        safePrint('Mutation failed: $e');
        showSnackbar(
          context,
          Snackbar(
            content: Text('API error $e'),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadingTaskBlock, ReadingTaskState>(
      buildWhen: (prev, current) =>
          prev.allTasks.length != current.allTasks.length,
      builder: (_, state) => NavigationView(
        appBar: const NavigationAppBar(title: Text("Fluent Design App Bar")),
        pane: NavigationPane(
          selected: index,
          menuButton: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Button(
                  child: Icon(
                    FluentIcons.add,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    Overlay.of(context).insert(_createTaskEverlay);
                  },
                ),
                const Expanded(child: SizedBox()),
                BlocConsumer<ReadingTaskBlock, ReadingTaskState>(
                    listener: (context, state) {
                      if (state.status.isError) {
                        Overlay.of(context).insert(_errorOverlay);
                      }
                    },
                    buildWhen: (prev, current) => prev.status != current.status,
                    builder: (_, state) {
                      if (state.status.isLoading) {
                        return const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: ProgressRing());
                      } else {
                        return const SizedBox();
                      }
                    }),
                Button(
                  child: Icon(
                    FluentIcons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Overlay.of(context).insert(_confirmDeleteOverlay);
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                Button(
                  child: Icon(
                    FluentIcons.save,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    context
                        .read<ReadingTaskBlock>()
                        .add(EventSaveReadingTask());
                  },
                ),
              ],
            ),
          ),
          displayMode: PaneDisplayMode.auto,
          items: [
            for (final task in state.allTasks)
              PaneItem(
                body: ReadingTaskEditorPage(currentTask: task),
                icon: const Icon(FluentIcons.book_answers),
                trailing: task.isNew
                    ? Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          FluentIcons.new_team_project,
                          color: Colors.orange,
                        ),
                      )
                    : const SizedBox(),
                title: Text(
                  '''${task.task.book} ${task.task.chapter}''',
                ),
              )
          ],
          onChanged: (newIndex) {
            setState(() {
              index = newIndex;
            });
          },
        ),
      ),
    );
  }
}

Future<void> _configureAmplify(BuildContext context) async {
  final api = AmplifyAPI(modelProvider: ModelProvider.instance);
  final auth = AmplifyAuthCognito();
  await Amplify.addPlugins([auth, api]);

  try {
    await Amplify.configure(amplifyconfig);
    showSnackbar(
      context,
      Snackbar(
        content: Text('Amplify configured!'),
      ),
    );
  } on Exception catch (e) {
    safePrint('An error occurred configuring Amplify: $e');
    showSnackbar(
      context,
      Snackbar(
        content: Text('Amplify error $e!'),
      ),
    );
  }
}
