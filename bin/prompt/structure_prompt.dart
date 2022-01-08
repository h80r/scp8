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
  int select(String name, List<String> options, [int initialIndex = 0]) {
    return Select.withTheme(
      prompt: 'Select which $name you want',
      options: options,
      theme: isColorful ? Theme.colorfulTheme : Theme.basicTheme,
      initialIndex: initialIndex,
    ).interact();
  }

  bool confirm(String prompt) {
    return Confirm.withTheme(
      theme: isColorful ? Theme.colorfulTheme : Theme.basicTheme,
      prompt: 'Do you want to $prompt?',
      defaultValue: false,
    ).interact();
  }

  List<int> multiSelect(String name, List<String> options) {
    return MultiSelect.withTheme(
      prompt: 'Select all $name related packages you wish to use',
      options: options,
      theme: isColorful ? Theme.colorfulTheme : Theme.basicTheme,
    ).interact();
  }

  final structureOptions = ['Complete Structure', 'Basic Structure'];
  final structureSelection = select('directory structure', structureOptions, 1);

  final wantGitSafe = confirm('generate `.gitkeep` files inside empty folders');

  final wantHooks = confirm('use Flutter Hooks with Riverpod');

  final wantDependencies = confirm('add default SCP dependencies');

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
  final interfaceSelection = multiSelect('UI', interfaceOptions);

  final serviceOptions = ['awesome_notifications', 'geolocator', 'workmanager'];
  final serviceSelection = multiSelect('service', serviceOptions);

  final storageOptions = [
    'cached_network_image',
    'flutter_dotenv',
    'flutter_secure_storage',
    'hive',
    'localstore',
    'path_provider',
    'shared_preferences',
  ];
  final storageSelection = multiSelect('storage', storageOptions);

  final httpOptions = ['None', 'dio', 'http'];
  final httpSelection = select('http package', httpOptions);

  final securityOptions = [
    'local_auth',
    'passcode_screen',
    'password_strength',
    'secure_application',
    'trust_fall',
  ];
  final securitySelection = multiSelect('security', securityOptions);

  final utilityOptions = [
    'fl_chart',
    'get_it',
    'package_info',
    'url_launcher',
  ];
  final utilitySelection = multiSelect('utility', utilityOptions);

  final developmentOptions = ['dartx', 'device_preview', 'faker', 'logger'];
  final developmentSelection = multiSelect('development', developmentOptions);

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
