import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wabiz_client/model/category/category_model.dart';
import 'package:wabiz_client/repository/category/category_repository.dart';
import 'package:wabiz_client/shared/model/project_type.dart';

part 'category_view_model.g.dart';
part 'category_view_model.freezed.dart';

enum CategoryProjectType {
  recommend('추천순'),
  lowFunded('낮은 펀딩금액순'),
  highFunded('높은 펀딩금액순');

  final String value;

  const CategoryProjectType(this.value);
}

/**
 * Data Class
 */
@freezed
class CategoryState with _$CategoryState {
  factory CategoryState({
    ProjectType? selectedType,
    @Default(CategoryProjectType.recommend) CategoryProjectType? projectFilter,
    @Default([]) List<CategoryItemModel> projects,
    @Default(AsyncValue.loading()) AsyncValue<List<CategoryItemModel>> projectState
  }) = _CategoryState;
}

@riverpod
class CategoryViewModel extends _$CategoryViewModel {
  @override
  CategoryState build() {
    return CategoryState(
      selectedType: ProjectType(id: 0, type: '전체'),
      projectFilter: CategoryProjectType.recommend,
      projects: []
    );
  }

  updateType(ProjectType type) {
    state = state.copyWith(
      selectedType: type,
      projectFilter: CategoryProjectType.recommend,
    );
  }

  fetchProjects(String categoryId) async {
    state = state.copyWith(projectState: const AsyncValue.loading());

    String typeId = '${state.selectedType?.id}';
    if(state.selectedType?.id == 0) {
      if(state.selectedType?.type == '전체') {
        typeId = 'all';
      } else {
        typeId = 'best';
      }
    }
    final AsyncValue<List<CategoryItemModel>> _state = await AsyncValue.guard(() async {
      final resp = await ref.watch(categoryRepositoryProvider).getCategoryProjects(categoryId, typeId);
      return resp.projects;
    });

    state = state.copyWith(
      projectState: _state,
      projects: _state.value ?? []
    );
  }

  updateProjectFilter(CategoryProjectType filter) {
    state = state.copyWith(
      projectState: AsyncValue.loading(),
      projectFilter: filter
    );
    final _projects = [...state.projects];
    if(filter == CategoryProjectType.lowFunded) {
      _projects.sort((a, b) {
        if((a.totalFunded ?? 0) > (b.totalFunded ?? 0)) {
          return 1;
        } else {
          return -1;
        }
      });
    } else if(filter == CategoryProjectType.highFunded) {
      _projects.sort((a, b) {
        if((a.totalFunded ?? 0) > (b.totalFunded ?? 0)) {
          return -1;
        } else {
          return 1;
        }
      });
    }
    state = state.copyWith(
      projectState: AsyncValue.data(_projects),
      projectFilter: filter
    );
  }
}

@riverpod
Future<List<ProjectType>> fetchTypeTabs(FetchTypeTabsRef ref) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return [
    const ProjectType(id: 0, type: '전체', imagePath: 'assets/icons/type/all.svg'),
    const ProjectType(id: 0, type: 'BEST 펀딩', imagePath: 'assets/icons/type/best.svg'),
    const ProjectType(id: 1, type: '테크가전', imagePath: 'assets/icons/type/1.svg'),
    const ProjectType(id: 2, type: '패션', imagePath: 'assets/icons/type/2.svg'),
    const ProjectType(id: 3, type: '뷰티', imagePath: 'assets/icons/type/3.svg'),
    const ProjectType(id: 4, type: '홈리빙', imagePath: 'assets/icons/type/4.svg'),
    const ProjectType(id: 5, type: '스포츠아웃도어', imagePath: 'assets/icons/type/5.svg'),
    const ProjectType(id: 6, type: '푸드', imagePath: 'assets/icons/type/6.svg'),
    const ProjectType(id: 7, type: '도서전자책', imagePath: 'assets/icons/type/7.svg'),
    const ProjectType(id: 8, type: '클래스', imagePath: 'assets/icons/type/8.svg'),
  ];
}

/*
  CategoryId에 맞는 Project
 */
@riverpod
Future<CategoryModel> fetchCategoryProjects(
  FetchCategoryProjectsRef ref,
  String categoryId
) async {
  final resp = await ref
      .watch(categoryRepositoryProvider)
      .getProjectsByCategoryId(categoryId);
  return resp;
}

@riverpod
Future<CategoryModel> fetchCategoryProjectsByType(
    FetchCategoryProjectsByTypeRef ref,
    String categoryId
) async {
  final viewModel = ref.watch(categoryViewModelProvider);
  String typeId = '${viewModel.selectedType?.id}';
  if(viewModel.selectedType?.id == 0) {
    if(viewModel.selectedType?.type == '전체') {
      typeId = 'all';
    } else {
      typeId = 'best';
    }
  }
  final resp = await ref
      .watch(categoryRepositoryProvider)
      .getCategoryProjects(categoryId, typeId);
  return resp;
}

