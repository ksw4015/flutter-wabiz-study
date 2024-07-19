import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:wabiz_client/theme.dart';
import 'package:wabiz_client/view_model/category/category_view_model.dart';
import 'package:wabiz_client/view_model/favorite/favorite_view_model.dart';

class CategoryPage extends ConsumerStatefulWidget {
  final String categoryId;

  const CategoryPage({
    super.key,
    required this.categoryId
  });

  @override
  ConsumerState<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends ConsumerState<CategoryPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(categoryViewModelProvider.notifier).fetchProjects(widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('카테고리'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {

            },
            icon: Icon(Icons.search,),
          ),
          IconButton(
            onPressed: () {
              
            },
            icon: SvgPicture.asset(
              'assets/icons/home_outlined.svg',
              width: 24,
              height: 24,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 204,
            child: Consumer(
              builder: (context, ref, child) {
                final datas = ref.watch(fetchCategoryProjectsProvider(widget.categoryId));
                return datas.when(
                    data: (data) {
                      final titleProject = data.projects[Random().nextInt((data.projects.length) - 1)];
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                titleProject.thumbnail ?? ''
                            ),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.2),
                              BlendMode.darken,
                            )
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${titleProject.title}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white
                              ),
                            ),
                            const Gap(12),
                            Text(
                              '전문가가 만든 이어폰 하나둘셋넷다섯, 전문가가 만든 이어폰 하나둘셋넷다섯,',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Gap(16),
                            Container(
                              height: 4,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: Colors.white
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    error: (error, trace) => Text('$error, $trace'),
                    loading: () => Center(
                      child: CircularProgressIndicator(),
                    )
                );
              }
            ),
          ),
          // TODO : TAP
          Container(
            height: 110,
            decoration: const BoxDecoration(
              color: Colors.white
            ),
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
            child: Consumer(
              builder: (context, ref, child) {
                final type = ref.watch(fetchTypeTabsProvider);
                return type.when(
                  data: (data) {
                    return Consumer(
                      builder: (context, ref, child) {
                        final viewModel = ref.watch(categoryViewModelProvider); // CategoryState
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final tab = data[index];
                            return GestureDetector(
                              onTap: () {
                                ref
                                    .read(categoryViewModelProvider.notifier)
                                    .updateType(tab);
                                // TODO : 데이터 가져오는 기능 추가
                                ref
                                    .read(categoryViewModelProvider.notifier)
                                    .fetchProjects(widget.categoryId);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: index == 0 ? 16 : 24
                                ),
                                child: IntrinsicWidth(
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                        tab.imagePath ?? '',
                                        width: 32,
                                        height: 32,
                                      ),
                                      const Gap(12),
                                      Text(
                                          '${tab.type}',
                                        style: TextStyle(
                                          fontWeight: viewModel.selectedType?.type == tab.type
                                              ? FontWeight.bold
                                              : FontWeight.normal
                                        ),
                                      ),
                                      const Gap(12),
                                      Container(
                                        height: 6,
                                        color: viewModel.selectedType?.type == tab.type
                                            ? Colors.black
                                            : Colors.transparent
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    );
                  },
                  error: (error, trace) {
                    return Text('$error, $trace');
                  },
                  loading: () {
                    return Center();
                  },
                );
              },
            ),
          ),
          const Divider(height: 0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Consumer(
                builder: (context, ref, child) {
                  final projects = ref.watch(categoryViewModelProvider).projectState;
                  return projects.when(
                    data: (data) {
                      if(data.isEmpty) {
                        return Center(
                          child: Text('등록된 프로젝트가 없습니다.'),
                        );
                      }
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              children: [
                                DropdownButton(
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('전체'),
                                    )
                                  ],
                                  onChanged: (value) {

                                  },
                                  icon: Icon(
                                      Icons.keyboard_arrow_down
                                  ),
                                  underline: SizedBox.shrink(),
                                ),
                                Gap(24),
                                Consumer(
                                  builder: (context, ref, child) {
                                    final filter = ref.watch(categoryViewModelProvider).projectFilter;
                                    return DropdownButton(
                                      value: filter,
                                      items: CategoryProjectType.values.map((e) {
                                        return DropdownMenuItem(
                                          value: e,
                                          onTap: () {
                                            ref
                                                .read(categoryViewModelProvider.notifier)
                                                .updateProjectFilter(e);
                                          },
                                          child: Text(e.value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                    
                                      },
                                      icon: Icon(
                                          Icons.keyboard_arrow_down
                                      ),
                                      underline: SizedBox.shrink(),
                                    );
                                  }
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final project = data[index];
                                return InkWell(
                                  onTap: () {
                                    context.push(
                                      '/detail',
                                      extra: json.encode(
                                        project.toJson()
                                      )
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 24),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 120,
                                          width: 164,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.blue,
                                            image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                '${project.thumbnail}'
                                              ),
                                              fit: BoxFit.cover,
                                              colorFilter: ColorFilter.mode(
                                                Colors.black.withOpacity(0.1),
                                                BlendMode.darken
                                              )
                                            ),
                                          ),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                right: 2,
                                                top: 2,
                                                child: Consumer(
                                                  builder: (context, ref, child) {
                                                    final favorites = ref.watch(favoriteViewModelProvider);
                                                    final current = favorites.projects.where((element) => element.id == project.id,).toList();
                                                    return IconButton(
                                                      onPressed: () {
                                                        if(current.isNotEmpty) {
                                                          showDialog(context: context, builder: (context) {
                                                            return AlertDialog(
                                                              content: Text('구독을 취소할까요?'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () {
                                                                    ref.read(favoriteViewModelProvider.notifier).removeItem(project);
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: Text(
                                                                    '네'
                                                                  ),
                                                                )
                                                              ],
                                                            );
                                                          });
                                                          return;
                                                        }
                                                        ref.read(favoriteViewModelProvider.notifier).addItem(project);
                                                      },
                                                      icon: Icon(
                                                        current.isNotEmpty
                                                            ? Icons.favorite
                                                            : Icons.favorite_border,
                                                        color: current.isNotEmpty
                                                            ? Colors.red
                                                            : Colors.white,
                                                      ),
                                                    );
                                                  }
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Gap(16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${project.title}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const Gap(6),
                                              Text(
                                                '${project.owner}',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: WabizColors.wabizGray[500]
                                                ),
                                              ),
                                              const Gap(4),
                                              Text(
                                                '${NumberFormat('###,###,###,###').format(project.totalFundedCount)}명 참여',
                                                style: const TextStyle(
                                                  color: WabizColors.primary,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const Gap(4),
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 6,
                                                    vertical: 4
                                                ),
                                                decoration: BoxDecoration(
                                                    color: WabizColors.background
                                                ),
                                                child: Text(
                                                  switch(project.totalFunded ?? 0) {
                                                    // >= 이 뭘 뜻하나 => 는 람다 return값
                                                    >= 100000000 && > 10000000 =>
                                                      '${NumberFormat.currency(
                                                        locale: 'ko_KR',
                                                        symbol: ''
                                                      ).format((project.totalFunded ?? 0) ~/ 100000000)}억 원+',
                                                    >= 10000000 && > 10000 =>
                                                      '${NumberFormat.currency(
                                                          locale: 'ko_KR',
                                                          symbol: ''
                                                      ).format((project.totalFunded ?? 0) ~/ 10000000)}천만 원+',
                                                    > 10000 =>
                                                      '${NumberFormat.currency(
                                                          locale: 'ko_KR',
                                                          symbol: ''
                                                      ).format((project.totalFunded ?? 0) ~/ 10000)}만 원+',
                                                    _ => ''
                                                  },
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      );
                    },
                    error: (error, trace) => Text('$error, $trace'),
                    loading: () => Center(
                      child: CircularProgressIndicator(),
                    )
                  );
                }
              ),
            ),
          )
        ],
      ),
    );
  }
}
