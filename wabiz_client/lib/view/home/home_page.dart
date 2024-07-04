import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wabiz_client/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                                contentPadding: EdgeInsets.symmetric(horizontal: 16),
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
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 0
                      ),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return const InkWell(
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 38,
                                backgroundColor: WabizColors.background,
                              ),
                              Gap(4),
                              Text('펀딩+')
                            ],
                          ),
                        );
                      },
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
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return InkWell(
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
                            spreadRadius: 4
                          )
                        ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 220,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)
                              )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '12,000명이 기다려요!',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: WabizColors.primary
                                  ),
                                ),
                                const Gap(8),
                                const Text(
                                  '아이돌 관리비법 | 준비안된 얼굴라인도 살리는 세럼',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                const Gap(16),
                                Text(
                                  '세상에 없던 브랜드',
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
                                  child: const Text(
                                    '오픈예정',
                                    style: TextStyle(
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
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
