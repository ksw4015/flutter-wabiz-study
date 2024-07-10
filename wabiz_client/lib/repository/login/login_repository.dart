import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wabiz_client/model/login/login_model.dart';
import 'package:wabiz_client/service/login/login_api.dart';
import 'package:wabiz_client/service/login/login_api_service.dart';
import 'package:wabiz_client/shared/model/response_model.dart';

part 'login_repository.g.dart';

class LoginRepository {
  LoginApi loginApi;

  LoginRepository(this.loginApi);

  Future<ResponseModel> signUp(LoginModel body) async {
    final response = await loginApi.signUp(body);
    return response;
  }

  Future<ResponseModel?> signIn(LoginModel body) async {
    final response = await loginApi.signIn(body);
    if(response.response.statusCode == 204) {
      return null;
    } else {
      return ResponseModel.fromJson(response.data);
    }
  }

  Future<ResponseModel> checkEmail(LoginModel body) async {
    final response = await loginApi.checkEmail(body);
    return response;
  }
}

@Riverpod(keepAlive: true)
LoginRepository loginRepository(LoginRepositoryRef ref) {
  final loginApi = ref.watch(loginApiProvider);
  return LoginRepository(loginApi);
}