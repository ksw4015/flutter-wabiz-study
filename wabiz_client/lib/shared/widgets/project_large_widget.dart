import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:wabiz_client/model/category/category_model.dart';
import 'package:wabiz_client/model/project/projcet_model.dart';
import 'package:wabiz_client/theme.dart';
import 'package:wabiz_client/view_model/favorite/favorite_view_model.dart';

class ProjectLargeWidget extends ConsumerWidget {
  final String projectDataString;
  final bool showFavorite;

  const ProjectLargeWidget({
    super.key,
    required this.projectDataString,
    this.showFavorite = false
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberFormatter = NumberFormat('###,###,###,###');
    ProjectItemModel project = ProjectItemModel.fromJson(jsonDecode(projectDataString));

    return InkWell(
      onTap: () {
        context.push(
          '/detail',
          extra: json.encode(project.toJson()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8, left: 16, right: 16, top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 8),
              color: Colors.black.withOpacity(0.1),
              blurRadius: 30,
              spreadRadius: 4,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)
                  ),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(project.thumbnail ?? ''),
                      fit: BoxFit.cover
                  )
              ),
              child: Stack(
                children: [
                  if(showFavorite)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(
                                    '구독을 취소할까요?'
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      ref.read(favoriteViewModelProvider.notifier).removeItem(CategoryItemModel(
                                        id: project.id
                                      ));
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                        '네'
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.favorite),
                        color: Colors.red,
                      ),
                    )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.isOpen == 'close' ?
                    '${numberFormatter.format(project.waitlistCount)}명이 기다려요' :
                    '${numberFormatter.format(project.totalFundedCount)}명이 인증했어요',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: WabizColors.primary
                    ),
                  ),
                  const Gap(8),
                  Text(
                    project.title ?? '아이돌 관리비법 | 준비안된 얼굴라인도 살리는 세럼',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const Gap(16),
                  Text(
                    project.owner ?? '세상에 없던 브랜드',
                    style: TextStyle(
                        color: WabizColors.wabizGray[500]
                    ),
                  ),
                  const Gap(16),
                  Container(
                    decoration: BoxDecoration(
                        color: WabizColors.background,
                        borderRadius: BorderRadius.circular(3)
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: Text(
                      project.isOpen == 'close' ? '오픈예정' : '바로구매',
                      style: const TextStyle(
                          fontSize: 10
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
  }
}
