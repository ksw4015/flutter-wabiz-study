import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:wabiz_client/shared/widgets/project_large_widget.dart';
import 'package:wabiz_client/theme.dart';
import 'package:wabiz_client/view_model/favorite/favorite_view_model.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<String> tabs = [
    '펀딩', '메이커', '알림신청', '펀딩/프리오더', '스토어'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '관심 있는 소식만 모았어요',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {

                    },
                    icon: Icon(
                      Icons.search
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 32,
              padding: const EdgeInsets.only(left: 16),
              child: ListView.builder(
                itemCount: tabs.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: index == tabs.length - 1 ? 16 : 12),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: WabizColors.newBackground,
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: Center(
                      child: Text(
                        tabs[index]
                      ),
                    ),
                  );
                },
              ),
            ),
            const Gap(12),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final favorites = ref.watch(favoriteViewModelProvider);
                  if(favorites.projects.isEmpty) {
                    return Center(
                      child: Text('등록된 관심(구독) 프로젝트가 없어요.'),
                    );
                  }
                  return ListView.builder(
                    itemCount: favorites.projects.length,
                    itemBuilder: (context, index) {
                      final project = favorites.projects[index];
                      return ProjectLargeWidget(
                        projectDataString: jsonEncode(project.toJson()),
                        showFavorite: true,
                      );
                    },
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
