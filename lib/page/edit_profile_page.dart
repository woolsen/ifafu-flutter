import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifafu/http/api.dart';
import 'package:ifafu/http/model.dart';
import 'package:ifafu/provider/user_provider.dart';
import 'package:ifafu/util/dialog.dart';
import 'package:ifafu/util/extensions.dart';
import 'package:ifafu/util/toast.dart'; // 导入自定义的Avatar组件

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  int randomId = 10000;

  final nicknameController = TextEditingController();
  String? area;
  String? gender;
  String? phone;
  late String avatarUrl;

  List<String> genders = ['男', '女', '保密'];
  List<String> areas = ['金山校区', '旗山校区', '安溪校区'];

  @override
  void initState() {
    super.initState();
    final initialUser = context.read<UserProvider>().state;
    if (initialUser == null) {
      Navigator.pop(context);
      Navigator.pushNamed(context, '/login');
      return;
    }
    nicknameController.text = initialUser.nickname;
    gender = initialUser.gender;
    area = initialUser.area;
    phone = initialUser.phone;
    avatarUrl = initialUser.avatarUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人中心'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: selectAvatar,
                    child: Container(
                      margin: const EdgeInsets.only(top: 16.0, bottom: 8),
                      width: 74,
                      height: 74,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: CircleAvatar(
                          radius: 37,
                          backgroundImage: NetworkImage(avatarUrl),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: randomAvatar,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF3C9CFF),
                        ),
                        child: const Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 0.5, height: 4),
            buildFormItem(
              '昵称',
              child: TextFormField(
                controller: nicknameController,
                decoration: const InputDecoration.collapsed(
                  hintText: '昵称',
                  border: InputBorder.none,
                ),
              ),
            ),
            const Divider(thickness: 0.5, height: 4),
            buildFormItem(
              '性别',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    gender ?? '请选择性别',
                    style: TextStyle(
                      color: gender != null ? Colors.black : Colors.black12,
                    ),
                  ),
                  const Icon(Icons.arrow_right),
                ],
              ),
              onTap: _showGenderDialog,
            ),
            const Divider(thickness: 0.5, height: 4),
            buildFormItem(
              '校区',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    area ?? '请选择校区',
                    style: TextStyle(
                      color: area != null ? Colors.black : Colors.black12,
                    ),
                  ),
                  const Icon(Icons.arrow_right),
                ],
              ),
              onTap: _showAreaDialog,
            ),
            const Divider(thickness: 0.5, height: 4),
            buildFormItem(
              '手机号',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    phone != null
                        ? phone!.replaceAllMapped(
                            RegExp(r'(\d{3})\d{4}(\d{2})'),
                            (match) =>
                                '${match.group(1)}******${match.group(2)}',
                          )
                        : '点击绑定',
                    style: TextStyle(
                      color: phone != null ? Colors.black : Colors.black12,
                    ),
                  ),
                  const Icon(Icons.arrow_right),
                ],
              ),
              onTap: _clickPhone,
            ),
            const Divider(thickness: 0.5, height: 4),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16.0),
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  save();
                },
                child: const Text('保存'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFormItem(
    String label, {
    required Widget child,
    GestureTapCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            width: 88,
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15.0,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (onTap != null) {
                  onTap();
                }
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  void selectAvatar() {
    // Handle avatar selection...
  }

  void randomAvatar() {
    randomId = randomId == 10050 ? 10001 : randomId + 1;
    final avatarUrl = randomAvatarUrl();
    this.avatarUrl = avatarUrl;
    setState(() {});
  }

  String randomAvatarUrl() {
    randomId = randomId == 10050 ? 10001 : randomId + 1;
    return 'https://minio.woolsen.cn/ifafu/avatar/$randomId.jpg';
  }

  Future<void> _showGenderDialog() async {
    final selectedValue =
        await showSimpleDialog(context, genders, title: '选择性别');
    if (selectedValue != null) {
      gender = selectedValue;
      setState(() {});
    }
  }

  Future<void> _showAreaDialog() async {
    final selectedValue = await showSimpleDialog(context, areas, title: '选择校区');
    if (selectedValue != null) {
      area = selectedValue;
      setState(() {});
    }
  }

  void _clickPhone() {
    // if (phone != null) {
    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         content: const Text('是否更换绑定手机号?'),
    //         actions: [
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //             child: const Text('取消'),
    //           ),
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //               gotoBindPhone();
    //             },
    //             child: const Text('更换'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // } else {
    //   gotoBindPhone();
    // }
  }

  void gotoBindPhone() {}

  void clickQQAuth(User user) {
    // if (containAuth(user, 'OPEN_QQ')) {
    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         content: const Text('是否解绑QQ?'),
    //         actions: [
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //             child: const Text('取消'),
    //           ),
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //               unbindQQ('OPEN_QQ');
    //             },
    //             child: const Text('解绑'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // } else {
    //   // Handle QQ binding...
    // }
  }

  // bool containAuth(User user, String auth) {
  //   return auths.contains(auth);
  // }

  void save() {
    final nickname = nicknameController.text;
    if (nickname.isBlank) {
      ToastUtil.show('昵称不能为空');
      return;
    }
    final update = UserUpdate(
      nickname: nickname,
      avatarUrl: avatarUrl,
      gender: gender,
      area: area,
    );
    Api.instance.editProfile(update).then((user) {
      context.read<UserProvider>().update(user);
      ToastUtil.show('保存成功');
      Navigator.of(context).pop();
    }).catchError((err) {
      ToastUtil.error(err, '保存失败');
    });
  }
}
