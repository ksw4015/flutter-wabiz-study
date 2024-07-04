import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wabiz_client/service/home/home_api.dart';
import 'package:wabiz_client/shared/network_provider.dart';

part 'home_api_service.g.dart';

@riverpod
HomeApi homeApiService(ref) {
  final dio = ref.watch(dioProvider);
  var localhost = 'localhost';
  // Android Emulator Localhost Address
  // if(defaultTargetPlatform == TargetPlatform.android) {
  //   localhost = '10.0.2.2';
  // }
  return HomeApi(
      dio,
      baseUrl: 'http://$localhost:3000/api/v1'
  );
}