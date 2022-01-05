import 'package:interact/interact.dart';

import '../schemas.dart';

const fastStructure = StructureSchema(
  wantFullStructure: true,
  wantGitSafe: true,
  wantHooks: true,
  willAddDependencies: false,
);

StructureSchema structurePrompt(bool isColorful) {
  final structureOptions = ['Complete Structure', 'Basic Structure'];
  final structureSelection = Select.withTheme(
    prompt: 'Which directory structure you want?',
    options: structureOptions,
    initialIndex: 1,
    theme: isColorful ? Theme.colorfulTheme : Theme.basicTheme,
  ).interact();

  final wantGitSafe = Confirm.withTheme(
    prompt: 'Do you want to generate `.gitkeep` files inside each '
        'folder for versioning purposes?',
    defaultValue: false,
    theme: isColorful ? Theme.colorfulTheme : Theme.basicTheme,
  ).interact();

  final wantHooks = Confirm.withTheme(
    prompt: 'Do you want to use Flutter Hooks with Riverpod?',
    defaultValue: false,
    theme: isColorful ? Theme.colorfulTheme : Theme.basicTheme,
  ).interact();

  final wantDependencies = Confirm.withTheme(
    prompt: 'Do you want to add default SCP dependencies?',
    defaultValue: false,
    theme: isColorful ? Theme.colorfulTheme : Theme.basicTheme,
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
  final storageSelection = MultiSelect.withTheme(
    prompt: 'Select all storage related packages you wish to use',
    options: storageOptions,
    theme: isColorful ? Theme.colorfulTheme : Theme.basicTheme,
  ).interact();

  final httpOptions = ['None', 'http', 'dio'];
  final httpSelection = Select.withTheme(
    prompt: 'Select the http package you want to add',
    options: httpOptions,
    theme: isColorful ? Theme.colorfulTheme : Theme.basicTheme,
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
