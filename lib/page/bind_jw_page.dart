import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ifafu/http/api.dart';
import 'package:ifafu/util/snackbar.dart';
import 'package:ifafu/util/toast.dart';

class BindJwPage extends StatefulWidget {
  const BindJwPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BindJwPageState();
}

class _BindJwPageState extends State<BindJwPage> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('绑定教务系统'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
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
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: '学号',
                  hintText: '请输入学号',
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  labelText: '密码',
                  hintText: '请输入密码',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: bindJw,
                  child: const Text('绑定'),
                ),
              ),
              const SizedBox(height: 16),
              RichText(
                text: const TextSpan(
                  text: '提示：密码即为教务系统密码\n教务系统网址: ',
                  style: TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(
                      text: 'https://jwgl.fafu.edu.cn/',
                      style: TextStyle(color: Colors.blue),
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
