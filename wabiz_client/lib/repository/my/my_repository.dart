import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_repository.g.dart';

@riverpod
MyRepository myRepository(MyRepositoryRef ref) {
  return MyRepositoryImpl();
}

abstract class MyRepository {
  Future getProjectsByUserId(String userId);
  Future updateProjectOpenState(String projectId);
  Future deleteProject(String projectId);
}

class MyRepositoryImpl implements MyRepository {
  @override
  Future deleteProject(String projectId) {
    // TODO: implement deleteProject
    throw UnimplementedError();
  }

  @override
  Future getProjectsByUserId(String userId) {
    // TODO: implement getProjectsByUserId
    throw UnimplementedError();
  }

  @override
  Future updateProjectOpenState(String projectId) {
    // TODO: implement updateProjectOpenState
    throw UnimplementedError();
  }
}