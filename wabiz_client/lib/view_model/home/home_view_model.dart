import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wabiz_client/model/home/home_model.dart';
import 'package:wabiz_client/repository/home/home_repository.dart';
import 'package:wabiz_client/shared/model/category.dart';
import 'package:wabiz_client/view/home/home_page.dart';

part 'home_view_model.g.dart';
part 'home_view_model.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    @Default([]) List<HomeItemModel> projects
  }) = _HomeState;
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  HomeRepository? homeRepository;

  @override
  HomeState? build() {
    homeRepository = ref.watch(homeRepositoryProvider);
    return null;
  }

  update(List<HomeItemModel> projects) {
    state = state?.copyWith(
      projects: [...projects]
    );
  }

  Future<HomeModel?> fetchHomeData() async {
    final result = await homeRepository?.getHomeProjects();
    update(result?.projects ?? []);
    return result;
  }
}

/*
  ViewModel의 UseCase(fetchHomeData)를 Provider로 제공
 */
@riverpod
Future<HomeModel> fetchHomeProject(FetchHomeProjectRef ref) async {
  try {
    final result = await ref.watch(homeViewModelProvider.notifier).fetchHomeData();
    return result ?? const HomeModel();
  } on DioException catch(error) {
    switch(error.type) {
      case DioExceptionType.connectionTimeout:
        throw ConnectionTimeoutError(error);
      case DioExceptionType.connectionError:
        throw ConnectionError(error);
      default:
        break;
    }
    return const HomeModel();
  }
}

@riverpod
Future<List<Category>> fetchHomeCategories(FetchHomeCategoriesRef ref) async {
  await Future.delayed(const Duration(milliseconds: 2000));
  List<Category> categories = const [
    Category(
      id: 1,
      iconPath: 'assets/icons/categories/1.png',
      title: '펀딩+',
    ),
    Category(
      id: 5,
      iconPath: 'assets/icons/categories/5.png',
      title: '혜택',
    ),
    Category(
      id: 2,
      iconPath: 'assets/icons/categories/2.png',
      title: '오픈예정',
    ),
    Category(
      id: 6,
      iconPath: 'assets/icons/categories/6.png',
      title: '펀딩체험단',
    ),
    Category(
      id: 3,
      iconPath: 'assets/icons/categories/3.png',
      title: '스토어',
    ),
    Category(
      id: 7,
      iconPath: 'assets/icons/categories/7.png',
      title: '뷰티워크',
    ),
    Category(
      id: 4,
      iconPath: 'assets/icons/categories/4.png',
      title: '예약구매',
    ),
    Category(
      id: 8,
      iconPath: 'assets/icons/categories/8.png',
      title: '새학기출발',
    ),
    Category(
      id: 5,
      iconPath: 'assets/icons/categories/5.png',
      title: '혜택',
    ),
    Category(
      id: 9,
      iconPath: 'assets/icons/categories/9.png',
      title: '클래스수강',
    )
  ];
  return categories;
}