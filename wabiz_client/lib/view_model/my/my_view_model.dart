import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wabiz_client/model/login/login_model.dart';
import 'package:wabiz_client/repository/my/my_repository.dart';
import 'package:wabiz_client/view_model/login/login_view_model.dart';

part 'my_view_model.g.dart';
part 'my_view_model.freezed.dart';

/**
 * MyPage (View)의 상태를 저장하는 Data class
 *
 */
@freezed
class MyPageState with _$MyPageState {
  factory MyPageState({
    bool? loginState,
    LoginModel? loginModel
  }) = _MyPageState;
}

/**
 * MyPageState를 관리하고 업데이트하는 ViewModel class
 */
@riverpod
class MyViewModel extends _$MyViewModel {
  @override
  MyPageState build() {
    final state = ref.watch(loginViewModelProvider);
    return MyPageState(
      loginState: state.isLogin,
      loginModel: LoginModel(
        email: state.email,
        username: state.userName,
        id: state.userId
      )
    );
  }

  fetchUserProjects() async {

  }

  updateProject(String projectId) async {
    await ref.watch(myRepositoryProvider).updateProjectOpenState(projectId);
  }

  deleteProject(String projectId) async {
    await ref.watch(myRepositoryProvider).deleteProject(projectId);
  }
}