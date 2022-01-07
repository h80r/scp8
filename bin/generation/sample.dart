import 'dart:io';

import 'package:interact/interact.dart';

void createSample({required String projectName, required String dir}) {
  void addFile(String path, {required String content}) {
    final spinner = Spinner(
      icon: '',
      rightPrompt: (done) => done ? '$path generated' : 'Generating $path',
    ).interact();

    final file = File(dir + path).openSync(mode: FileMode.write);
    file.writeStringSync(content);
    file.closeSync();

    spinner.done();
  }

  addFile(
    'main.dart',
    content: mainContent.replaceAll('project_name', projectName),
  );
  addFile('schema/canvas/home.dart', content: schemaContent);
  addFile(
    'canvas/home.dart',
    content: canvasContent.replaceAll('project_name', projectName),
  );
  addFile(
    'provider/canvas/home.dart',
    content: providerContent.replaceAll('project_name', projectName),
  );
}

const mainContent = '''
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:project_name/canvas/home.dart';

void main() {
  runApp(
    // The ProviderScope widget saves the state of all Providers, so it needs to
    // be at the top of your Widget tree.
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: HomeCanvas(title: 'Flutter Demo Home Page'),
    );
  }
}

''';

const schemaContent = '''
class HomeSchema {
  HomeSchema({
    required this.count,
  });

  final int count;

  HomeSchema copyWith({
    int? count,
  }) {
    return HomeSchema(
      count: count ?? this.count,
    );
  }
}

''';

const canvasContent = '''
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:project_name/provider/canvas/home.dart';

class HomeCanvas extends ConsumerWidget {
  const HomeCanvas({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is a consumer, meaning
  // that it has a WidgetRef inside its build method which can affect how it
  // behaves.

  // This class is the configuration for the canvas. It holds the values (in
  // this case the title) provided by the parent (in this case the App widget).
  // Fields in a Widget subclass are always marked 'final'.

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This variable will provide the state of the widget.
    final state = ref.watch(homeProvider);

    // This variable can be used to make changes to the state.
    final notifier = ref.watch(homeProvider.notifier);

    // This method is rerun every time the notifier promotes a change to the
    // state, for instance as done by the notifier.increment call below.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the HomeCanvas object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '\${state.count}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: notifier.increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

''';

const providerContent = '''
import 'package:riverpod/riverpod.dart';
import 'package:project_name/schema/canvas/home.dart';

// Providers are declared as globals to be watched.
final homeProvider = StateNotifierProvider<HomeNotifier, HomeSchema>((ref) {
  return HomeNotifier();
});

// The state notifier get it's state type from <T>.
class HomeNotifier extends StateNotifier<HomeSchema> {
  // The value inside this super constructor represets the state initial value.
  HomeNotifier() : super(HomeSchema(count: 0));

  // This state change tells the Flutter framework to rerun the build method
  // of any consumer widget so that the display can reflect the updated values.
  void increment() => state = state.copyWith(count: state.count + 1);
}

''';
