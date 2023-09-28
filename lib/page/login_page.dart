import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: top),
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 80),
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
                        FilteringTextInputFormatter.allow(_phoneRegex),
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
                    obscureText: true,
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
                          onTap: _getVerificationCode,
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
                  onPressed: () {},
                  child: const Text('登录'),
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  _getVerificationCode() async {
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
      //TODO 发送验证码
      _showToast('验证码已发送');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
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
    try {
      //TODO 登录
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      _showToast('登录失败');
      return;
    }
  }

  void _showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
