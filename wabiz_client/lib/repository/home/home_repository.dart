import 'package:wabiz_client/service/home/home_api.dart';
import 'package:wabiz_client/service/home/home_api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/home/home_model.dart';

part 'home_repository.g.dart';

abstract class HomeRepository {
  Future<HomeModel> getHomeProjects();
}

class HomeRepositoryImpl implements HomeRepository {
  HomeApi homeApiService;

  HomeRepositoryImpl(this.homeApiService);

  @override
  Future<HomeModel> getHomeProjects() async {
    final result = await homeApiService.getHomeProjects();
    return result;
  }
}

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  final service = ref.watch(homeApiServiceProvider);
  return HomeRepositoryImpl(service);
}