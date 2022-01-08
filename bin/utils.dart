import 'dart:io';

import 'package:interact/interact.dart';
import 'package:linter/src/rules/pub/package_names.dart';
import 'package:linter/src/utils.dart';

Future<void> runProcess(
  String command, {
  required String icon,
  String Function(bool done)? prompt,
  String? dir,
}) async {
  final spinner = Spinner(
    icon: icon,
    rightPrompt: prompt ?? (done) => '',
  ).interact();

  final args = command.split(' ');
  final executable = args.removeAt(0);

  await Process.run(executable, args, workingDirectory: dir);
  spinner.done();
}

Future<bool> isConnected() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}

String? validateProjectName(String projectName) {
  if (!isValidPackageName(projectName)) {
    final details = PubPackageNames().details;
    return '"$projectName" is not a valid project name. $details';
  }
  if (_packageDependencies.contains(projectName)) {
    return 'The name \'$projectName\' will conflict with Flutter dependencies.';
  }
  return null;
}

const _packageDependencies = <String>{
  'analyzer',
  'args',
  'async',
  'collection',
  'convert',
  'crypto',
  'flutter',
  'flutter_test',
  'front_end',
  'html',
  'http',
  'intl',
  'io',
  'isolate',
  'kernel',
  'logging',
  'matcher',
  'meta',
  'mime',
  'path',
  'plugin',
  'pool',
  'test',
  'utf',
  'watcher',
  'yaml',
};

String parseSampleContent(
  String content, {
  required String projectName,
  required bool useHooks,
}) {
  return content
      .replaceAll('project_name', projectName)
      .replaceAll('riverpod', useHooks ? 'hooks_riverpod' : 'flutter_riverpod');
}

List<String>? parseMultiSelect(List<int> selections, List<String> options) {
  if (selections.isEmpty) return null;
  return [for (final id in selections) options[id]];
}
