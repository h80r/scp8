import 'package:interact/interact.dart';

import '../schemas.dart';
import '../utils.dart';

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

  final interfaceOptions = [
    'bottom_navy_bar',
    'day_night_time_picker',
    'font_awesome_flutter',
    'image_picker',
    'intro_slider',
  ];
  final interfaceSelection = MultiSelect.withTheme(
    prompt: 'Select all UI related packages you wish to use',
    options: interfaceOptions,
    theme: isColorful ? Theme.colorfulTheme : Theme.basicTheme,
  ).interact();

  final serviceOptions = [
    'awesome_notifications',
    'geolocator',
    'workmanager',
  ];
  final serviceSelection = MultiSelect.withTheme(
    prompt: 'Select all service related packages you wish to use',
    options: serviceOptions,
    theme: isColorful ? Theme.colorfulTheme : Theme.basicTheme,
  ).interact();

  final storageOptions = [
    'cached_network_image',
    'flutter_dotenv',
    'flutter_secure_storage',
    'hive',
    'localstore',
    'path_provider',
    'shared_preferences',
  ];
  final storageSelection = MultiSelect.withTheme(
    prompt: 'Select all storage related packages you wish to use',
    options: storageOptions,
    theme: isColorful ? Theme.colorfulTheme : Theme.basicTheme,
  ).interact();

  final httpOptions = ['None', 'dio', 'http'];
  final httpSelection = Select.withTheme(
    prompt: 'Select the http package you want to add',
    options: httpOptions,
    theme: isColorful ? Theme.colorfulTheme : Theme.basicTheme,
  ).interact();

  final securityOptions = [
    'local_auth',
    'passcode_screen',
    'password_strength',
    'secure_application',
    'trust_fall',
  ];
  final securitySelection = MultiSelect.withTheme(
    prompt: 'Select all security related packages you wish to use',
    options: securityOptions,
    theme: isColorful ? Theme.colorfulTheme : Theme.basicTheme,
  ).interact();

  final utilityOptions = [
    'fl_chart',
    'get_it',
    'package_info',
    'url_launcher',
  ];
  final utilitySelection = MultiSelect.withTheme(
    prompt: 'Select all utility packages you wish to use',
    options: utilityOptions,
    theme: isColorful ? Theme.colorfulTheme : Theme.basicTheme,
  ).interact();

  final developmentOptions = ['dartx', 'device_preview', 'faker', 'logger'];
  final developmentSelection = MultiSelect.withTheme(
    prompt: 'Select all development related packages you wish to use',
    options: developmentOptions,
    theme: isColorful ? Theme.colorfulTheme : Theme.basicTheme,
  ).interact();

  return StructureSchema(
    wantFullStructure: structureSelection == 0,
    wantGitSafe: wantGitSafe,
    wantHooks: wantHooks,
    willAddDependencies: wantDependencies,
    interfaceDependencies: parseMultiSelect(
      interfaceSelection,
      interfaceOptions,
    ),
    serviceDependencies: parseMultiSelect(serviceSelection, serviceOptions),
    storageDependencies: parseMultiSelect(storageSelection, storageOptions),
    httpDependency: httpSelection == 0 ? null : httpOptions[httpSelection],
    securityDependencies: parseMultiSelect(securitySelection, securityOptions),
    utilityDependencies: parseMultiSelect(utilitySelection, utilityOptions),
    developmentDependencies: parseMultiSelect(
      developmentSelection,
      developmentOptions,
    ),
  );
}
