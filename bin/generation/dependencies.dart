import '../schemas.dart';
import '../utils.dart';

Future<void> createDependencies(StructureSchema settings, String dir) async {
  Future<void> addDependency(String? package) async {
    if (package == null) return;
    return await runProcess(
      'flutter pub add $package',
      icon: '',
      prompt: (done) => done ? '$package added' : 'Adding $package',
      dir: dir,
    );
  }

  Future<void> addList(List<String>? packages) async {
    for (final package in packages ?? []) {
      await addDependency(package);
    }
  }

  await addDependency(
    settings.wantHooks ? 'hooks_riverpod' : 'flutter_riverpod',
  );

  if (settings.wantHooks) {
    await addDependency('flutter_hooks');
  }

  if (!settings.willAddDependencies) return;

  await addList(settings.interfaceDependencies);
  await addList(settings.serviceDependencies);
  await addList(settings.storageDependencies);
  await addDependency(settings.httpDependency);
  await addList(settings.securityDependencies);
  await addList(settings.utilityDependencies);
  await addList(settings.developmentDependencies);
}
