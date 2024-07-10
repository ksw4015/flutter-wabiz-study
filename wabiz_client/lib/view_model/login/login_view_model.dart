import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wabiz_client/model/login/login_model.dart';
import 'package:wabiz_client/repository/login/login_repository.dart';
import 'package:wabiz_client/shared/model/response_model.dart';

part 'login_view_model.g.dart';
part 'login_view_model.freezed.dart';

@freezed
class LoginState with _$LoginState {
  factory LoginState({
    @Default(false) bool isLogin,
    int? userId,
    String? email,
    String? userName,
    String? password
  }) = _LoginState;

  factory LoginState.init() {
    return LoginState(
      isLogin: false,
      userId: 0,
      email: '',
      userName: '',
      password: ''
    );
  }
}

@Riverpod(keepAlive: true)
class LoginViewModel extends _$LoginViewModel {
  @override
  LoginState build() {
    return LoginState.init();
  }

  Future<bool> signUp(LoginModel body) async {
    final response = await ref.watch(loginRepositoryProvider).signUp(body);
    if(response.status == 'ok') {
      return true;
    }
    return false;
  }

  Future<ResponseModel?> signIn(String email, String password) async {
    final response = await ref.watch(loginRepositoryProvider).signIn(
        LoginModel(email: email, password: password)
    );
    if(response != null) {
      final data = LoginModel.fromJson(jsonDecode(response.body ?? ''));
      state = state.copyWith(
        isLogin: true,
        userId: data.id,
        email: data.email,
        userName: data.username
      );
    }
    return response;
  }

  Future<bool> checkEmail(LoginModel body) async {
    final response = await ref.watch(loginRepositoryProvider).checkEmail(body);
    if(response.status == 'ok') {
      return true;
    }
    return false;
  }

  bool signOut() {
    state = state.copyWith(
      isLogin: false,
      email: '',
      userName: '',
      password: ''
    );
    return true;
  }
}