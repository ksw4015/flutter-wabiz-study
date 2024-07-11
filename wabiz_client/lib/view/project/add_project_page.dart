import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:wabiz_client/shared/enum/enum_project.dart';
import 'package:wabiz_client/shared/model/project_type.dart';
import 'package:wabiz_client/theme.dart';

const addProjectTitleStyle = TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 16
);

class AddProjectPage extends StatefulWidget {
  const AddProjectPage({super.key});

  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  ProjectClass selectedProjectClass = ProjectClass.funding;

  TextEditingController priceTextEditingController = TextEditingController();
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController makerTextEditingController = TextEditingController();
  TextEditingController deadlineTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController = TextEditingController();

  ProjectType? projectType;
  XFile? image;

  @override
  void dispose() {
    priceTextEditingController.dispose();
    titleTextEditingController.dispose();
    makerTextEditingController.dispose();
    deadlineTextEditingController.dispose();
    descriptionTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '프로젝트 정보'
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '카테고리',
                style: addProjectTitleStyle,
              ),
              Gap(12),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container();
                    },
                  );
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: WabizColors.wabizGray[200]!,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${projectType != null ? projectType!.type : '카테고리 선택'}'),
                      IconButton(
                        onPressed: () {

                        },
                        icon: Icon(Icons.keyboard_arrow_down),
                      )
                    ],
                  ),
                ),
              ),
              Gap(24),
              const Text(
                '프로젝트 유형',
                style: addProjectTitleStyle,
              ),
              Gap(12),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: WabizColors.wabizGray[200]!
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    _projectClassButton(ProjectClass.funding),
                    _projectClassButton(ProjectClass.preOrder),
                    _projectClassButton(ProjectClass.preOrderGlobal),
                    _projectClassButton(ProjectClass.preOrderEncore),
                  ],
                ),
              ),
              Gap(24),
              Text(
                '목표 금액',
                style: addProjectTitleStyle,
              ),
              Gap(12),
              Text(
                '최소 50만원 ~ 최대 1억원 사이에서 설정해 주세요.'
              ),
              Gap(12),
              TextFormField(
                controller: priceTextEditingController,
                decoration: InputDecoration(
                  hintText: '목표 금액을 입력해 주세요.'
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              Gap(24),
              Text(
                '프로젝트 제목',
                style: addProjectTitleStyle,
              ),
              Gap(12),
              TextFormField(
                controller: titleTextEditingController,
                decoration: InputDecoration(
                    hintText: '제목을 입력해 주세요.'
                ),
                maxLength: 40,
              ),
              Gap(24),
              Text(
                '프로젝트 메이커',
                style: addProjectTitleStyle,
              ),
              Gap(12),
              TextFormField(
                controller: makerTextEditingController,
                decoration: InputDecoration(
                    hintText: '메이커 명을 입력해 주세요.'
                ),
              ),
              Gap(24),
              Text(
                '대표 이미지',
                style: addProjectTitleStyle,
              ),
              Gap(12),
              Text(
                '메인, 검색 결과, SNS 광고 등 여러 곳에서 노출할 대표 이미지를 등록해 주세요.',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: WabizColors.wabizGray[400]
                ),
              ),
              Gap(12),
              InkWell(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  image = await picker.pickImage(source: ImageSource.gallery);
                  setState(() {

                  });
                },
                child: Container(
                  height: 70,
                  width: 86,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: WabizColors.wabizGray[200]!
                    )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt
                      ),
                      Text(
                        '${image == null ? '0' : '1'}/1'
                      )
                    ],
                  ),
                ),
              ),
              Gap(24),
              Text(
                '프로젝트 종료일',
                style: addProjectTitleStyle,
              ),
              Gap(12),
              TextFormField(
                controller: deadlineTextEditingController,
                decoration: InputDecoration(
                    hintText: '예시) 2024-05-05',
                  suffixIcon: IconButton(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2024, 12, 31),
                      );
                      deadlineTextEditingController.text = DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());
                    },
                    icon: Icon(
                      Icons.calendar_month
                    ),
                  )
                ),
              ),
              Gap(24),
              Text(
                '프로젝트 요약',
                style: addProjectTitleStyle,
              ),
              Gap(12),
              Text(
                '소개 영상이나 사진과 함께 보이는 글이에요. 프로젝트를 쉽게 간결하게 소개해주세요.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: WabizColors.wabizGray[400]
                ),
              ),
              Gap(12),
              TextFormField(
                controller: descriptionTextEditingController,
                decoration: InputDecoration(
                  hintText: '내용 입력',
                ),
                maxLines: 4,
                maxLength: 100,
              ),
              Gap(12),
              MaterialButton(
                onPressed: () {

                },
                height: 50,
                minWidth: double.infinity,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                color: WabizColors.primary,
                child: Text(
                  '저장하기',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _projectClassButton(ProjectClass projectClass) {
    return RadioListTile(
      value: projectClass,
      groupValue: selectedProjectClass,
      onChanged: (v) {
        setState(() {
          selectedProjectClass = v ?? projectClass;
        });
      },
      title: Text(projectClass.title ?? ''),
      subtitle: Text(projectClass.subtitle ?? ''),
    );
  }
}
