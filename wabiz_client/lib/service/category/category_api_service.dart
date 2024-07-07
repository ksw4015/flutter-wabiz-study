import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wabiz_client/service/category/category_api.dart';
import 'package:wabiz_client/shared/network_provider.dart';

part 'category_api_service.g.dart';

@riverpod
CategoryApi categoryApiService(CategoryApiServiceRef ref) {
  final dio = ref.watch(dioProvider);
  return CategoryApi(dio);
}