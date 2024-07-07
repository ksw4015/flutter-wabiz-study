import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wabiz_client/model/category/category_model.dart';
import 'package:wabiz_client/service/category/category_api.dart';
import 'package:wabiz_client/service/category/category_api_service.dart';

part 'category_repository.g.dart';

@riverpod
CategoryRepository categoryRepository(CategoryRepositoryRef ref) {
  final service = ref.watch(categoryApiServiceProvider);
  return CategoryRepository(service);
}

class CategoryRepository {
  CategoryApi categoryApi;

  CategoryRepository(this.categoryApi);

  Future<CategoryModel> getCategoryProjects(String categoryId, String typeId) async {
    final result = await categoryApi.getProjectByProjectTypeId(categoryId, typeId);
    return result;
  }

  Future<CategoryModel> getProjectsByCategoryId(String categoryId) async {
    final result = await categoryApi.getProjectByCategoryId(categoryId);
    return result;
  }
}