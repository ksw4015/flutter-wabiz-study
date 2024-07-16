// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchProjectTypesHash() => r'0851d8d9240d9d2ce4a009ddf1bf9eb88dc38730';

/// See also [fetchProjectTypes].
@ProviderFor(fetchProjectTypes)
final fetchProjectTypesProvider =
    AutoDisposeFutureProvider<List<ProjectType>>.internal(
  fetchProjectTypes,
  name: r'fetchProjectTypesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchProjectTypesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchProjectTypesRef = AutoDisposeFutureProviderRef<List<ProjectType>>;
String _$projectDetailViewModelHash() =>
    r'2fc5200820be8139f60bf03f08be5f6a6cfdace5';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ProjectDetailViewModel
    extends BuildlessAutoDisposeAsyncNotifier<ProjectItemModel> {
  late final String id;

  FutureOr<ProjectItemModel> build(
    String id,
  );
}

/// See also [ProjectDetailViewModel].
@ProviderFor(ProjectDetailViewModel)
const projectDetailViewModelProvider = ProjectDetailViewModelFamily();

/// See also [ProjectDetailViewModel].
class ProjectDetailViewModelFamily
    extends Family<AsyncValue<ProjectItemModel>> {
  /// See also [ProjectDetailViewModel].
  const ProjectDetailViewModelFamily();

  /// See also [ProjectDetailViewModel].
  ProjectDetailViewModelProvider call(
    String id,
  ) {
    return ProjectDetailViewModelProvider(
      id,
    );
  }

  @override
  ProjectDetailViewModelProvider getProviderOverride(
    covariant ProjectDetailViewModelProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'projectDetailViewModelProvider';
}

/// See also [ProjectDetailViewModel].
class ProjectDetailViewModelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ProjectDetailViewModel,
        ProjectItemModel> {
  /// See also [ProjectDetailViewModel].
  ProjectDetailViewModelProvider(
    String id,
  ) : this._internal(
          () => ProjectDetailViewModel()..id = id,
          from: projectDetailViewModelProvider,
          name: r'projectDetailViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$projectDetailViewModelHash,
          dependencies: ProjectDetailViewModelFamily._dependencies,
          allTransitiveDependencies:
              ProjectDetailViewModelFamily._allTransitiveDependencies,
          id: id,
        );

  ProjectDetailViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  FutureOr<ProjectItemModel> runNotifierBuild(
    covariant ProjectDetailViewModel notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(ProjectDetailViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProjectDetailViewModelProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ProjectDetailViewModel,
      ProjectItemModel> createElement() {
    return _ProjectDetailViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProjectDetailViewModelProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProjectDetailViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<ProjectItemModel> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ProjectDetailViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ProjectDetailViewModel,
        ProjectItemModel> with ProjectDetailViewModelRef {
  _ProjectDetailViewModelProviderElement(super.provider);

  @override
  String get id => (origin as ProjectDetailViewModelProvider).id;
}

String _$projectViewModelHash() => r'0187526170c259f99d2627fa17c073174daac831';

/// See also [ProjectViewModel].
@ProviderFor(ProjectViewModel)
final projectViewModelProvider =
    AutoDisposeNotifierProvider<ProjectViewModel, ProjectItemModel?>.internal(
  ProjectViewModel.new,
  name: r'projectViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$projectViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProjectViewModel = AutoDisposeNotifier<ProjectItemModel?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
