import 'dart:io';

import 'package:interact/interact.dart';

import '../utils.dart';

String? namePrompt(bool isColorful) {
  final name = Input.withTheme(
    prompt: 'Please insert your project name',
    theme: isColorful ? Theme.colorfulTheme : Theme.basicTheme,
  ).interact().toLowerCase().replaceAll(' ', '_');

  final targetDir = FileSystemEntity.typeSync('./' + name);
  if (targetDir != FileSystemEntityType.notFound) {
    final tryAgain = Confirm(
      prompt: 'A file or directory with the given name already exists.'
          ' Do you want to try again (y) or cancel (n)?',
      defaultValue: true,
    ).interact();

    return tryAgain ? namePrompt(isColorful) : null;
  }

  final validation = validateProjectName(name);
  if (validation != null) {
    final tryAgain = Confirm(
      prompt: validation + ' Do you want to try again (y) or cancel (n)?',
      defaultValue: true,
    ).interact();

    return tryAgain ? namePrompt(isColorful) : null;
  }

  return name;
}
