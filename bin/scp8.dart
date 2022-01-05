import 'dart:io';

import 'package:args/args.dart';

import 'generation/dependencies.dart';
import 'generation/folders.dart';
import 'generation/sample.dart';
import 'prompt/name_prompt.dart';
import 'prompt/structure_prompt.dart';
import 'utils.dart';

void main(List<String> arguments) async {
  final argumentsParser = ArgParser()
    ..addFlag(
      'fast',
      abbr: 'f',
      negatable: false,
    );

  final args = argumentsParser.parse(arguments);

  print(
    'Hello! This simple tool will setup your Flutter project following the '
    'SCP Architecture!',
  );

  if (!await isConnected()) {
    print(
      'Sadly, for this generator to work you need internet connection.'
      ' Try again later!',
    );
    return;
  }

  final structureSettings = args['fast'] ? fastStructure : structurePrompt();
  final projectName = namePrompt();
  if (projectName == null) return;

  await runProcess(
    'flutter create $projectName',
    icon: 'ﱦ',
    prompt: (done) =>
        done ? 'Flutter project generated' : 'Generating flutter project',
  );

  final flutterRoot = Directory('./' + projectName + '/').path;

  createFolders(structureSettings, flutterRoot + 'lib/');

  await createDependencies(structureSettings, flutterRoot);

  createSample(projectName: projectName, dir: flutterRoot + 'lib/');
}
