import 'dart:io';

import 'package:interact/interact.dart';

import '../utils.dart';

String? namePrompt() {
  final name = Input(
    prompt: 'Please insert your project name:',
  ).interact().toLowerCase().replaceAll(' ', '_');

  final targetDir = FileSystemEntity.typeSync('./' + name);
  if (targetDir != FileSystemEntityType.notFound) {
    final tryAgain = Confirm(
      prompt: 'A file or directory with the given name already exists.'
          ' Do you want to try again (y) or cancel (n)?',
      defaultValue: true,
    ).interact();

    return tryAgain ? namePrompt() : null;
  }

  final validation = validateProjectName(name);
  if (validation != null) {
    final tryAgain = Confirm(
      prompt: validation + ' Do you want to try again (y) or cancel (n)?',
      defaultValue: true,
    ).interact();

    return tryAgain ? namePrompt() : null;
  }

  return name;
}
