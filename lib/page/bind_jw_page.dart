import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ifafu/http/api.dart';
import 'package:ifafu/util/snackbar.dart';
import 'package:ifafu/util/toast.dart';
import 'package:ifafu/widget/input_field.dart';

class BindJwPage extends StatefulWidget {
  const BindJwPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BindJwPageState();
}

class _BindJwPageState extends State<BindJwPage> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('绑定教务系统'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/image/logo_fafu.png',
                    width: 240,
                    fit: BoxFit.fitWidth,
                  ),
                  Image.asset(
                    'assets/image/logo_jw.png',
                    width: 160,
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              InputField(
                controller: _usernameController,
                hintText: '学号',
                prefix: const Icon(Icons.person),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              InputField(
                controller: _passwordController,
                isPassword: true,
                hintText: '密码',
                prefix: const Icon(Icons.lock),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: bindJw,
                  child: const Text('绑定'),
                ),
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  text: '提示：密码即为正方教务系统密码\n教务系统网址: ',
                  style: const TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(
                      text: 'http://jwgl.fafu.edu.cn/',
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Clipboard.setData(
                            const ClipboardData(
                              text: 'http://jwgl.fafu.edu.cn/',
                            ),
                          );
                          ToastUtil.show('网址已复制到剪贴板');
                        },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void bindJw() {
    final username = _usernameController.text;
    final password = _passwordController.text;
    if (username.isEmpty) {
      ToastUtil.show('请输入学号');
      return;
    }
    if (password.isEmpty) {
      ToastUtil.show('请输入密码');
      return;
    }
    Api.instance.bindJw(username, password).then((value) {
      ToastUtil.show('绑定成功');
      Navigator.pop(context, true);
    }).catchError((e) {
      if (e is DioException && e.response?.data['code'] == 402) {
        SnackBarUtil.show(
          context,
          '该学号已被绑定至其他账号，如有疑问请提交反馈',
          action: SnackBarAction(
            label: '提交反馈',
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/feedback');
            },
          ),
        );
      } else {
        ToastUtil.error(e);
      }
    });
  }
}
