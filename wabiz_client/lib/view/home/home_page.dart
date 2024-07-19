import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
                    error: (error, stackTrace) => Text('$error, $stackTrace}'),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                  // final project = ref.watch(homeViewModelProvider.notifier).fetchHomeData();
                  // return FutureBuilder(
                  //   future: project,
                  //   builder: (context, snapshot) {
                  //     if(snapshot.hasData) {
                  //       final data = snapshot.data;
                  //       if(data?.projects.isEmpty ?? true) {
                  //         return Column(
                  //           children: [
                  //             Text('정보가 없습니다.'),
                  //             TextButton(
                  //               onPressed: () {
                  //
                  //               },
                  //               child: Text('새로고침'),
                  //             )
                  //           ],
                  //         );
                  //       }
                  //       return Container(
                  //         color: Colors.white,
                  //         child: ListView.builder(
                  //           itemCount: data?.projects.length,
                  //           itemBuilder: (context, index) {
                  //             final project = data?.projects[index];
                  //             return InkWell(
                  //               child: Container(
                  //                 margin: const EdgeInsets.only(bottom: 8, left: 16, right: 16, top: 20),
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.white,
                  //                     borderRadius: BorderRadius.circular(10),
                  //                     boxShadow: [
                  //                       BoxShadow(
                  //                           offset: const Offset(0, 8),
                  //                           color: Colors.black.withOpacity(0.1),
                  //                           blurRadius: 30,
                  //                           spreadRadius: 4
                  //                       )
                  //                     ]
                  //                 ),
                  //                 child: Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   children: [
                  //                     Container(
                  //                       height: 220,
                  //                       decoration: BoxDecoration(
                  //                           color: Colors.grey,
                  //                           borderRadius: const BorderRadius.only(
                  //                               topLeft: Radius.circular(10),
                  //                               topRight: Radius.circular(10)
                  //                           ),
                  //                         image: DecorationImage(
                  //                           image: CachedNetworkImageProvider(project?.thumbnail ?? ''),
                  //                           fit: BoxFit.cover
                  //                         )
                  //                       ),
                  //                     ),
                  //                     Padding(
                  //                       padding: const EdgeInsets.all(16.0),
                  //                       child: Column(
                  //                         crossAxisAlignment: CrossAxisAlignment.start,
                  //                         children: [
                  //                           Text(
                  //                             project?.isOpen == 'close' ?
                  //                             '${numberFormatter.format(project?.waitlistCount)}명이 기다려요'
                  //                             : '${numberFormatter.format(project?.totalFundedCount)}명이 인증했어요',
                  //                             style: const TextStyle(
                  //                                 fontSize: 18,
                  //                                 fontWeight: FontWeight.w700,
                  //                                 color: WabizColors.primary
                  //                             ),
                  //                           ),
                  //                           const Gap(8),
                  //                           Text(
                  //                             project?.title ?? '아이돌 관리비법 | 준비안된 얼굴라인도 살리는 세럼',
                  //                             style: const TextStyle(
                  //                               fontSize: 12,
                  //                             ),
                  //                           ),
                  //                           const Gap(16),
                  //                           Text(
                  //                             project?.owner ?? '세상에 없던 브랜드',
                  //                             style: TextStyle(
                  //                                 color: WabizColors.wabizGray[500]
                  //                             ),
                  //                           ),
                  //                           const Gap(16),
                  //                           Container(
                  //                             decoration: BoxDecoration(
                  //                                 color: WabizColors.background,
                  //                                 borderRadius: BorderRadius.circular(3)
                  //                             ),
                  //                             padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  //                             child: Text(
                  //                               project?.isOpen == 'close' ? '오픈예정' : '바로구매',
                  //                               style: const TextStyle(
                  //                                   fontSize: 10
                  //                               ),
                  //                             ),
                  //                           )
                  //                         ],
                  //                       ),
                  //                     )
                  //                   ],
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //         ),
                  //       );
                  //     }
                  //     return Center(
                  //       child: CircularProgressIndicator(),
                  //     );
                  //   },
                  // );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
