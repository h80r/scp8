import '../schemas.dart';
import '../utils.dart';

Future<void> createDependencies(StructureSchema settings, String dir) async {
  Future<void> addDependency(String package) async {
    return await runProcess(
      'flutter pub add $package',
      icon: '',
      prompt: (done) => done ? '$package added' : 'Adding $package',
      dir: dir,
    );
  }

  await addDependency(
    settings.wantHooks ? 'hooks_riverpod' : 'flutter_riverpod',
  );

  if (settings.wantHooks) {
    await addDependency('flutter_hooks');
  }

  if (!settings.willAddDependencies) return;

  for (final dependency in settings.storageDependencies ?? []) {
    await addDependency(dependency);
  }

  final httpDependency = settings.httpDependency;
  if (httpDependency != null) {
    await addDependency(httpDependency);
  }
}
