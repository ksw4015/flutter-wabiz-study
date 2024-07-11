import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wabiz_client/theme.dart';
import 'package:wabiz_client/view/project/add_project_page.dart';

class AddRewardPage extends StatefulWidget {
  final String projectId;

  const AddRewardPage({
    super.key,
    required this.projectId
  });

  @override
  State<AddRewardPage> createState() => _AddRewardPageState();
}

class _AddRewardPageState extends State<AddRewardPage> {
  TextEditingController priceEditingController = TextEditingController();
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    priceEditingController.dispose();
    titleEditingController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '리워드'
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '리워드 추가',
                style: addProjectTitleStyle,
              ),
              Gap(12),
              DottedBorder(
                color: WabizColors.wabizGray[200]!,
                dashPattern: [5,5],
                borderType: BorderType.RRect,
                radius: Radius.circular(10),
                child: Container(
                  height: 216,
                  width: double.infinity,
                  color: Color(0xFFFBFBFB),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle
                      ),
                      Gap(12),
                      Text('리워드를 추가해주세요.')
                    ],
                  ),
                ),
              ),
              Gap(24),
              Text(
                '금액',
                style: addProjectTitleStyle,
              ),
              Gap(12),
              TextFormField(
                controller: priceEditingController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '0'
                ),
              ),
              Gap(24),
              Text(
                '리워드명',
                style: addProjectTitleStyle,
              ),
              Gap(12),
              TextFormField(
                controller: titleEditingController,
                decoration: InputDecoration(
                  hintText: '예시)[얼리버드] 베이지 이불, 베개 1세트',
                ),
                maxLength: 60,
              ),
              Gap(24),
              Text(
                '리워드 설명',
                style: addProjectTitleStyle,
              ),
              Gap(12),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: '리워드 구성과 혜택을 간결하게 설명해주세요.',
                ),
                maxLength: 400,
                maxLines: 10,
              ),
              Gap(12),
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          context.go('/my');
                        },
                        child: Text('취소'),
                      ),
                    ),
                    Gap(12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context.go('/my');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: WabizColors.primary
                          ),
                          child: Center(
                            child: Text(
                              '추가',
                              style: addProjectTitleStyle.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
