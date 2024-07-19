import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../model/category/category_model.dart';

part 'category_api.g.dart';

@RestApi(baseUrl: 'http://localhost:3000/api/v1')
abstract class CategoryApi {
  factory CategoryApi(Dio dio, {String baseUrl}) = _CategoryApi;

  @GET('/category/{categoryId}/{projectTypeId}')
  Future<CategoryModel> getProjectByProjectTypeId(
    @Path() String? categoryId,
    @Path() String? projectTypeId
  );

  @GET('/category/{categoryId}')
  Future<CategoryModel> getProjectByCategoryId(
      @Path() String? categoryId,
  );
}