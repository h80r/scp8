class StructureSchema {
  const StructureSchema({
    required this.wantFullStructure,
    required this.wantGitSafe,
    required this.wantHooks,
    required this.willAddDependencies,
    this.interfaceDependencies,
    this.serviceDependencies,
    this.storageDependencies,
    this.httpDependency,
    this.securityDependencies,
    this.utilityDependencies,
    this.developmentDependencies,
  });

  final bool wantFullStructure;
  final bool wantGitSafe;
  final bool wantHooks;
  final bool willAddDependencies;
  final List<String>? interfaceDependencies;
  final List<String>? serviceDependencies;
  final List<String>? storageDependencies;
  final String? httpDependency;
  final List<String>? securityDependencies;
  final List<String>? utilityDependencies;
  final List<String>? developmentDependencies;
}
