import 'dart:io';

import 'package:interact/interact.dart';

import '../schemas.dart';

void createFolders(StructureSchema settings, String dir) {
  void addGitSafe(String dir) {
    if (settings.wantGitSafe) {
      final file = File(dir + '.gitkeep');
      file.createSync();
    }
  }

  void addFolder(String name, {String? parent}) {
    final hasParent = parent != null;
    final trailingText = hasParent ? ' inside $parent' : '';

    final folder = Directory(
      dir + (hasParent ? parent + '/' : '') + name + '/',
    );

    final spinner = Spinner(
      icon: '',
      rightPrompt: (done) => done
          ? '$name folder generated$trailingText'
          : 'Generating $name folder$trailingText',
    ).interact();

    folder.createSync();

    addGitSafe(folder.path);
    spinner.done();
  }

  addFolder('schema');
  addFolder('canvas');
  addFolder('provider');
  addFolder('components', parent: 'canvas');
  addFolder('canvas', parent: 'provider');

  if (settings.wantFullStructure) {
    addFolder('enums', parent: 'schema');
    addFolder('utils');
  }
}
