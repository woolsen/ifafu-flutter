import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ifafu/http/api.dart';
import 'package:ifafu/provider/user_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneController = TextEditingController();

  final _codeController = TextEditingController();

  final grey = const Color.fromRGBO(0x99, 0x99, 0x99, 1);

  // 验证码提示
  String _codeHint = '获取验证码';
  bool _isCodeClickable = true;

  final _phoneRegex = RegExp(r'^1\d{10}$');

  bool _loging = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 48),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    child: const Text(
                      'iFAFU',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'DingTalk',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: TextField(
                      controller: _phoneController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(11),
                      ],
                      decoration: const InputDecoration(
                        hintText: '手机',
                        prefixIcon: Icon(
                          Icons.phone_android, // 这里使用了手机图标
                          color: Colors.blue, // 可以设置图标的颜色
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  //验证码输入框
                  TextField(
                    controller: _codeController,
                    decoration: InputDecoration(
                      hintText: '验证码',
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.blue,
                      ),
                      suffixIcon: Container(
                        width: 100,
                        margin: const EdgeInsets.only(right: 10),
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: _getSmsCode,
                          child: Text(
                            _codeHint,
                            style: _isCodeClickable
                                ? const TextStyle(color: Colors.blue)
                                : const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50, left: 50, right: 50),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _login,
                  child: _loging
                      ? const CircularProgressIndicator()
                      : const Text('登录'),
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  _getSmsCode() async {
    var phone = _phoneController.text;
    if (phone.isEmpty) {
      _showToast('请输入手机号');
      return;
    }
    if (!RegExp(r"^1[3456789]\d{9}$").hasMatch(phone)) {
      _showToast('手机号格式不正确');
      return;
    }
    if (!_isCodeClickable) {
      return;
    }
    _isCodeClickable = false;
    _codeHint = '60s后重新获取';
    setState(() {});
    try {
      await Api.instance.getSmsCode(phone);
      _showToast('验证码已发送');
    } catch (e) {
      _showToast('验证码获取失败');
      _isCodeClickable = true;
      _codeHint = '获取验证码';
      setState(() {});
      return;
    }
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _codeHint = '${60 - timer.tick}s后重新获取';
      if (timer.tick == 60) {
        _codeHint = '重发验证码';
        _isCodeClickable = true;
        timer.cancel();
      }
      setState(() {});
    });
  }

  _login() {
    var phone = _phoneController.text;
    var code = _codeController.text;
    if (phone.isEmpty) {
      _showToast('请输入手机号');
      return;
    }
    if (!_phoneRegex.hasMatch(phone)) {
      _showToast('手机号格式不正确');
      return;
    }
    if (code.isEmpty) {
      _showToast('请输入验证码');
      return;
    }
    _loging = true;
    setState(() {});
    Api.instance.login(phone, code).then((user) {
      context.read<UserProvider>().update(user);
      _showToast('登录成功');
      Navigator.of(context).pop();
    }).catchError((e) {
      if (kDebugMode) {
        print(e);
      }
      _showToast('登录失败');
    }).whenComplete(() {
      _loging = false;
      setState(() {});
    });
  }

  void _showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
