import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dio/dio.dart';

part 'network_provider.g.dart';

@riverpod
Dio dio(DioRef ref) {
  var localhost = 'localhost';
  // Android Emulator Localhost Address
  // if(defaultTargetPlatform == TargetPlatform.android) {
  //   localhost = '10.0.2.2';
  // }
  final options = BaseOptions(
    baseUrl: 'http://$localhost:3000/api/v1/',
    responseType: ResponseType.json,
    headers: {
      'Content-Type': 'application/json'
    },
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30)
  );
  return Dio(options);
}