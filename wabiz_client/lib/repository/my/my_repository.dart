import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wabiz_client/model/project/projcet_model.dart';
import 'package:wabiz_client/service/project/project_api.dart';
import 'package:wabiz_client/service/project/project_api_service.dart';
import 'package:wabiz_client/shared/model/response_model.dart';

part 'my_repository.g.dart';

@riverpod
MyRepository myRepository(MyRepositoryRef ref) {
  final service = ref.watch(projectApiServiceProvider);
  return MyRepositoryImpl(service);
}

abstract class MyRepository {
  Future getProjectsByUserId(String userId);
  Future updateProjectOpenState(String projectId, ProjectItemModel body);
  Future deleteProject(String projectId);
}

class MyRepositoryImpl implements MyRepository {
  ProjectApiClient projectApiService;

  MyRepositoryImpl(this.projectApiService);

  @override
  Future<ResponseModel> deleteProject(String projectId) async {
    final result = await projectApiService.deleteProject(projectId);
    return result;
  }

  @override
  Future<ProjectModel> getProjectsByUserId(String userId) async {
    final result = await projectApiService.getProjectByUserId(userId);
    return result;
  }

  @override
  Future<ResponseModel> updateProjectOpenState(String projectId, ProjectItemModel body) async {
    final result = await projectApiService.updateProjectOpenState(projectId, body);
    return result;
  }
}