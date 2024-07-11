import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wabiz_client/service/project/project_api.dart';
import 'package:wabiz_client/shared/network_provider.dart';

part 'project_api_service.g.dart';

@riverpod
ProjectApiClient projectApiService(ProjectApiServiceRef ref) {
  final dio = ref.watch(dioProvider);
  return ProjectApiClient(dio);
}