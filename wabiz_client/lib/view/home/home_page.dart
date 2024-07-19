import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:wabiz_client/shared/widgets/project_large_widget.dart';
import 'package:wabiz_client/theme.dart';
import 'package:wabiz_client/view_model/home/home_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final numberFormatter = NumberFormat('###,###,###,###');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WabizColors.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 324,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextFormField(
                              onTap: () {

                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: WabizColors.wabizGray[100]!
                                  )
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: WabizColors.wabizGray[100]!,
                                    ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                    color: WabizColors.primary,
                                  ),
                                ),
                                hintText: '새로운 일상이 필요하신가요?',
                                suffixIcon: const Icon(
                                  Icons.search,
                                ),
                                suffixIconColor: WabizColors.wabizGray[400]!
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {

                          },
                          icon: const Icon(
                            Icons.notifications_none
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, bottom: 8),
                      child: Consumer(
                        builder: (context, ref, child) {
                          final categories = ref.watch(fetchHomeCategoriesProvider);
                          return switch(categories) {
                            AsyncData(:final value) => GridView.builder(
                              scrollDirection: Axis.horizontal,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 0
                              ),
                              itemCount: value.length,
                              itemBuilder: (context, index) {
                                final data = value[index];
                                return InkWell(
                                  onTap: () {
                                    // push는 화면 스택을 쌓는다.
                                    context.push('/home/category/${data.id}');
                                  },
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 38,
                                        backgroundColor: WabizColors.background,
                                        child: Image.asset(
                                          data.iconPath ?? '',
                                          height: 42,
                                          width: 42,
                                        ),
                                      ),
                                      const Gap(4),
                                      Text(data.title ?? '')
                                    ],
                                  ),
                                );
                              },
                            ),
                            AsyncError(:final error) => Text('$error'),
                            _ => const Center(
                              child: CircularProgressIndicator(),
                            )
                          };
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 48,
                    height: 4,
                    decoration: BoxDecoration(
                      color: WabizColors.background,
                      borderRadius: BorderRadius.circular(2)
                    ),
                  ),
                  const Gap(12)
                ],
              ),
            ),
            const Gap(12),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final homeData = ref.watch(fetchHomeProjectProvider);
                  return homeData.when(
                    data: (data) {
                      if(data.projects.isEmpty) {
                        return Column(
                          children: [
                            const Text('정보가 없습니다.'),
                            TextButton(
                              onPressed: () {
                                ref.invalidate(fetchHomeProjectProvider);
                              },
                              child: const Text('새로고침'),
                            )
                          ],
                        );
                      }
                      return Container(
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount: data.projects.length,
                          itemBuilder: (context, index) {
                            final project = data.projects[index];
                            return ProjectLargeWidget(projectDataString: jsonEncode(project.toJson()));
                          },
                        ),
                      );
                    },
                    error: (error, stackTrace) {
                      switch(error) {
                        case ConnectionTimeoutError():
                        case ConnectionError():
                          return Center(
                            child: Text('${error.toString()}\n${stackTrace.toString()}'),
                          );
                        case UnsupportedError():
                          return Center(
                            child: Text('${error.toString()}'),
                          );
                      }
                      return globalErrorHandler(
                        error as ErrorHandler,
                        error as DioException,
                        ref,
                        fetchHomeProjectProvider,
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

sealed class ErrorHandler {}

class ConnectionTimeoutError extends ErrorHandler {
  DioException exception;
  ConnectionTimeoutError(this.exception);
}

class ConnectionError extends ErrorHandler {
  DioException exception;
  ConnectionError(this.exception);
}

Widget globalErrorHandler(
    ErrorHandler? errorHandler,
    DioException? exception,
    WidgetRef? ref,
    ProviderOrFamily? provider
) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("${exception?.message}"),
        if(ref != null)
          TextButton(
            onPressed: () {
              if(provider != null) {
                ref.invalidate(provider);
              }
            },
            child: const Text('새로고침'),
          ),
        TextButton(
          onPressed: () {
            Clipboard.setData(
              ClipboardData(text: exception?.stackTrace.toString() ?? '')
            );
          },
          child: const Text(
            '에러 전송'
          ),
        )
      ],
    ),
  );
}
