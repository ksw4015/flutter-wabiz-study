// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchHomeProjectHash() => r'329b1aa68c254854b3097f988d46cff36539d4ef';

/// See also [fetchHomeProject].
@ProviderFor(fetchHomeProject)
final fetchHomeProjectProvider = AutoDisposeFutureProvider<HomeModel>.internal(
  fetchHomeProject,
  name: r'fetchHomeProjectProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchHomeProjectHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchHomeProjectRef = AutoDisposeFutureProviderRef<HomeModel>;
String _$fetchHomeCategoriesHash() =>
    r'27d51b23207dfd500bc1be50270fac49d54cf476';

/// See also [fetchHomeCategories].
@ProviderFor(fetchHomeCategories)
final fetchHomeCategoriesProvider =
    AutoDisposeFutureProvider<List<Category>>.internal(
  fetchHomeCategories,
  name: r'fetchHomeCategoriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchHomeCategoriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchHomeCategoriesRef = AutoDisposeFutureProviderRef<List<Category>>;
String _$homeViewModelHash() => r'dcb3daba5fdd4af188142f6e4dc7467f1e92a72d';

/// See also [HomeViewModel].
@ProviderFor(HomeViewModel)
final homeViewModelProvider =
    AutoDisposeNotifierProvider<HomeViewModel, HomeState?>.internal(
  HomeViewModel.new,
  name: r'homeViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeViewModel = AutoDisposeNotifier<HomeState?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
