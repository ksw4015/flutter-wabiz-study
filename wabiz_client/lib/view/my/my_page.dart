import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wabiz_client/model/project/projcet_model.dart';
import 'package:wabiz_client/theme.dart';
import 'package:wabiz_client/view_model/login/login_view_model.dart';
import 'package:wabiz_client/view_model/my/my_view_model.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('마이페이지'),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: WabizColors.wabizGray[900]
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer(
          builder: (context, ref, child) {
            final myState = ref.watch(myViewModelProvider);
            return Column(
              children: [
                Container(
                  height: 470,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          if(myState.loginState ?? false) {
                            return Row(
                              children: [
                                const CircleAvatar(
                                  radius: 24,
                                  backgroundColor: WabizColors.background,
                                ),
                                const Gap(8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${myState.loginModel?.email}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Gap(4),
                                      Text(
                                        '${myState.loginModel?.username}님 안녕하세요?',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: Text(
                                          '로그아웃 할까요?'
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              '취소'
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              ref.read(loginViewModelProvider.notifier).signOut();
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              '확인',
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.logout),
                                  tooltip: '로그아웃',
                                )
                              ],
                            );
                          }
                          return Row(
                            children: [
                              const CircleAvatar(
                                radius: 24,
                                backgroundColor: WabizColors.background,
                              ),
                              const Gap(8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context.push('/login');
                                    },
                                    child: const Row(
                                      children: [
                                        Text(
                                          '로그인하기',
                                        ),
                                        Icon(Icons.keyboard_arrow_right)
                                      ],
                                    ),
                                  ),
                                  const Text(
                                    '로그인 후 다양한 프로젝트에 참여해보세요.',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400
                                    ),
                                  )
                                ],
                              )
                            ],
                          );
                        }
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          final isLogin = ref.watch(myViewModelProvider).loginState ?? false;
                          if(!isLogin) {
                            return const _EmptyProjectWidget();
                          }
                          return FutureBuilder(
                            future: ref.read(myViewModelProvider.notifier).fetchUserProjects(),
                            builder: (context, snapshot) {
                              if(snapshot.hasData) {
                                List<ProjectItemModel> list = snapshot.data ?? [];
                                if(list.isEmpty) {
                                  return const _EmptyProjectWidget();
                                }
                                return Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Gap(24),
                                      Text(
                                        '나의 프로젝트'
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: list.length,
                                          itemBuilder: (context, index) {
                                            final project = list[index];
                                            return ListTile(
                                              title: Text('${project.title}'),
                                              subtitle: Text(
                                                '${project.description}',
                                                maxLines: 2,
                                              ),
                                              leading: Text(
                                                '${project.type}'
                                              ),
                                              trailing: PopupMenuButton(
                                                itemBuilder: (context) {
                                                  return [
                                                    PopupMenuItem(
                                                      onTap: () {
                                                        context.push('/add/reward/${project.id}');
                                                      },
                                                      child: Text(
                                                        '리워드 추가'
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      onTap: () {
                                                        showDialog(context: context, builder: (context) {
                                                          bool openState = project.isOpen == 'open';
                                                          return StatefulBuilder(
                                                            builder: (context, setState) {
                                                              return AlertDialog(
                                                                title: Text('프로젝트 수정'),
                                                                content: Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    SwitchListTile.adaptive(
                                                                      title: Text('오픈상태'),
                                                                      value: openState,
                                                                      onChanged: (value) {
                                                                      setState(() {
                                                                        openState = value;
                                                                      });
                                                                    },)
                                                                  ],
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () async {
                                                                      final result = await ref
                                                                          .read(myViewModelProvider.notifier)
                                                                          .updateProject(project.id.toString(), project.copyWith(isOpen: openState ? 'open' : 'close'));
                                                                      if(result) {
                                                                        if(context.mounted) {
                                                                          Navigator.of(context).pop();
                                                                        }
                                                                      }
                                                                    },
                                                                    child: Text('저장'),
                                                                  )
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },);
                                                      },
                                                      child: Text(
                                                          '프로젝트 오픈상태 수정'
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              content: Text('삭제하시겠습니까?'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () async {
                                                                    final result = await ref.read(myViewModelProvider.notifier).deleteProject(project.id.toString());
                                                                    if(result) {
                                                                      if(context.mounted) {
                                                                        Navigator.of(context).pop();
                                                                        setState(() {

                                                                        });
                                                                      }
                                                                    }
                                                                  },
                                                                  child: Text('삭제'),
                                                                )
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Text(
                                                          '프로젝트 삭제'
                                                      ),
                                                    ),
                                                  ];
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }
                              if(snapshot.hasError) {
                                return Center(
                                  child: Text(
                                    '${snapshot.error}'
                                  ),
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            },
                          );
                        },
                      ),
                      InkWell(
                        onTap: () {
                          if(myState.loginState != true) {
                            showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                content: Text(
                                  '로그인이 필요한 서비스입니다.'
                                ),
                              ),
                            );
                            return;
                          }
                          context.push('/add');
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: WabizColors.primary,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: const Center(
                            child: Text(
                              '프로젝트 만들기',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}

class _EmptyProjectWidget extends StatelessWidget {
  const _EmptyProjectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: WabizColors.wabizGray[200],
          child: SvgPicture.asset(
            'assets/icons/featured_seasonal_and_gifts.svg',
            width: 28,
            height: 28,
            colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn
            ),
          ),
        ),
        const Gap(20),
        const Text(
          '새로운 도전을\n시작해보세요',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12
          ),
          textAlign: TextAlign.center,
        ),
        const Gap(20),
        const Text(
          '개인 후원부터 제품, 콘텐츠, 서비스 출시, 성장까지 함께할게요.',
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 11
          ),
        )
      ],
    );
  }
}
