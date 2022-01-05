import 'package:interact/interact.dart';

import '../schemas.dart';

const fastStructure = StructureSchema(
  wantFullStructure: true,
  wantGitSafe: true,
  wantHooks: true,
  willAddDependencies: false,
);

StructureSchema structurePrompt() {
  final structureOptions = ['Complete Structure', 'Basic Structure'];
  final structureSelection = Select(
    prompt: 'Which directory structure do you want?',
    options: structureOptions,
    initialIndex: 1,
  ).interact();

  final wantGitSafe = Confirm(
    prompt: 'Do you want to generate `.gitkeep` files inside each '
        'folder for versioning purposes?',
    defaultValue: false,
  ).interact();

  final wantHooks = Confirm(
    prompt: 'Do you want to use Flutter Hooks with Riverpod?',
    defaultValue: false,
  ).interact();

  final wantDependencies = Confirm(
    prompt: 'Do you want to add default SCP dependencies?',
    defaultValue: false,
  ).interact();

  if (!wantDependencies) {
    return StructureSchema(
      wantFullStructure: structureSelection == 0,
      wantGitSafe: wantGitSafe,
      wantHooks: wantHooks,
      willAddDependencies: wantDependencies,
    );
  }

  final storageOptions = [
    'flutter_dotenv',
    'shared_preferences',
    'flutter_secure_storage',
    'path_provider',
    'localstore',
    'cached_network_image',
  ];
  final storageSelection = MultiSelect(
    prompt: 'Select all storage related packages you wish to use:',
    options: storageOptions,
  ).interact();

  final httpOptions = ['None', 'http', 'dio'];
  final httpSelection = Select(
    prompt: 'Which http package do you want to add?',
    options: httpOptions,
  ).interact();

  return StructureSchema(
    wantFullStructure: structureSelection == 0,
    wantGitSafe: wantGitSafe,
    wantHooks: wantHooks,
    willAddDependencies: wantDependencies,
    storageDependencies: storageSelection.isEmpty
        ? null
        : storageOptions
            .where((element) =>
                storageSelection.contains(storageOptions.indexOf(element)))
            .toList(),
    httpDependency: httpSelection == 0 ? null : httpOptions[httpSelection],
  );
}
