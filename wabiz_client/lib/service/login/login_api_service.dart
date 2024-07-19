import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wabiz_client/service/login/login_api.dart';
import 'package:wabiz_client/shared/network_provider.dart';

part 'login_api_service.g.dart';

@Riverpod(keepAlive: true)
LoginApi loginApi(LoginApiRef ref) {
  final dio = ref.watch(dioProvider);
  return LoginApi(dio);
}