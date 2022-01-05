class StructureSchema {
  const StructureSchema({
    required this.wantFullStructure,
    required this.wantGitSafe,
    required this.wantHooks,
    required this.willAddDependencies,
    this.storageDependencies,
    this.httpDependency,
  });

  final bool wantFullStructure;
  final bool wantGitSafe;
  final bool wantHooks;
  final bool willAddDependencies;
  final List<String>? storageDependencies;
  final String? httpDependency;
}
