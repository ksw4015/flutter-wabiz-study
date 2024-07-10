import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wabiz_client/model/login/login_model.dart';
import 'package:wabiz_client/theme.dart';
import 'package:wabiz_client/view_model/login/login_view_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _password2TextController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _validated = false;

  @override
  void dispose() {
    _emailTextController.dispose();
    _userNameTextController.dispose();
    _passwordTextController.dispose();
    _password2TextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '이메일 간편가입',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: WabizColors.wabizGray[900]
                  ),
                ),
                const Gap(20),
                const Text(
                  '이메일 계정',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                ),
                const Gap(12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _emailTextController,
                        decoration: const InputDecoration(
                          hintText: '아이디 입력'
                        ),
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return '필수 입력 항목입니다.';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const Gap(12),
                    Consumer(
                      builder: (context, ref, child) {
                        return GestureDetector(
                          onTap: () async {
                            final result = await ref.read(loginViewModelProvider.notifier).checkEmail(
                                LoginModel(
                                    email: _emailTextController.text.trim(),
                                    username: _userNameTextController.text.trim(),
                                    password: _passwordTextController.text.trim()
                                )
                            );
                            if(context.mounted) {
                              if(result) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Text('등록 가능한 아이디 입니다.'),
                                  ),
                                );
                                _validated = true;
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Text('이미 등록된 아이디 입니다.'),
                                  ),
                                );
                                _validated = false;
                              }
                            }
                          },
                          child: Container(
                            height: 62,
                            width: 90,
                            decoration: BoxDecoration(
                              color: WabizColors.primary.withOpacity(0.55),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: const Center(
                              child: Text(
                                '인증하기',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    )
                  ],
                ),
                const Gap(20),
                const Text(
                  '이름',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),
                ),
                const Gap(12),
                TextFormField(
                  controller: _userNameTextController,
                  decoration: const InputDecoration(
                      hintText: '이름 입력'
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return '필수 입력 항목입니다.';
                    } else {
                      return null;
                    }
                  },
                ),
                const Gap(20),
                const Text(
                  '비밀번호',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),
                ),
                const Gap(12),
                TextFormField(
                  controller: _passwordTextController,
                  decoration: InputDecoration(
                    hintText: '비밀번호 입력',
                    filled: true,
                    fillColor: WabizColors.newBackground,
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () {

                      },
                    )
                  ),
                  obscureText: true,
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return '필수 입력 항목입니다.';
                    } else {
                      return null;
                    }
                  },
                ),
                const Gap(12),
                TextFormField(
                  controller: _password2TextController,
                  decoration: InputDecoration(
                      hintText: '비밀번호 확인',
                      filled: true,
                      fillColor: WabizColors.newBackground,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.visibility),
                        onPressed: () {

                        },
                      )
                  ),
                  obscureText: true,
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return '필수 입력 항목입니다.';
                    }
                    if(value != _passwordTextController.text.trim()) {
                      return '비밀번호가 다릅니다!';
                    }
                    return null;
                  },
                ),
                const Gap(20),
                Consumer(
                  builder: (context, ref, child) {
                    return GestureDetector(
                      onTap: () async {
                        // Form위젯 하위의 모든 InputForm의 검증 실행?
                        if(_formKey.currentState!.validate()) {
                          _formKey.currentState?.save();
                          if(_validated) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: const Text(
                                  '이메일 인증하기를 해주세요!',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      context.pop();
                                      context.pop();
                                    },
                                    child: const Text(
                                      '확인',
                                    ),
                                  )
                                ],
                              ),
                            );
                            return;
                          }
                          final result = await ref.read(loginViewModelProvider.notifier).signUp(
                            LoginModel(
                              email: _emailTextController.text.trim(),
                              username: _userNameTextController.text.trim(),
                              password: _passwordTextController.text.trim()
                            )
                          );
                          if(context.mounted) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Text(
                                  result
                                  ? '등록 성공: 로그인을 진행해주세요.'
                                  : '신규 회원가입 실패',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      context.pop();
                                      context.pop();
                                    },
                                    child: Text(
                                        '확인'
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: WabizColors.primary.withOpacity(0.55),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Center(
                          child: Text(
                            '약관 동의 후 가입 완료하기',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
