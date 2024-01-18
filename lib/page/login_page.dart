import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ifafu/http/api.dart';
import 'package:ifafu/provider/user_provider.dart';
import 'package:ifafu/util/toast.dart';
import 'package:ifafu/widget/input_field.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneController = TextEditingController();

  final _codeController = TextEditingController();

  // 验证码提示
  String _codeHint = '获取验证码';
  bool _isCodeClickable = true;
  Timer? _getSmsCodeTimer;

  final _phoneRegex = RegExp(r'^1\d{10}$');

  bool _loging = false;

  @override
  void dispose() {
    super.dispose();
    _getSmsCodeTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '登录',
          style: TextStyle(color: Colors.black),
        ),
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
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lottie/login.json', width: 140),
                  InputField(
                    controller: _phoneController,
                    hintText: '手机号',
                    prefix: const Icon(
                      Icons.phone_android,
                      color: Colors.blue,
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(11),
                    ],
                  ),
                  const SizedBox(height: 18),
                  //验证码输入框
                  InputField(
                    controller: _codeController,
                    hintText: '验证码',
                    prefix: const Icon(
                      Icons.lock,
                      color: Colors.blue,
                    ),
                    suffix: Container(
                      width: 100,
                      margin: const EdgeInsets.only(right: 10),
                      alignment: Alignment.centerRight,
                      child: Text(
                        _codeHint,
                        style: _isCodeClickable
                            ? const TextStyle(color: Colors.blue)
                            : const TextStyle(color: Colors.grey),
                      ),
                    ),
                    onSuffixTap: _getSmsCode,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(6),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 24, left: 50, right: 50),
              child: SizedBox(
                width: double.infinity,
                height: 44,
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
      ToastUtil.show('请输入手机号');
      return;
    }
    if (!RegExp(r"^1[3456789]\d{9}$").hasMatch(phone)) {
      ToastUtil.show('手机号格式不正确');
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
      ToastUtil.show('验证码已发送');
    } catch (e) {
      ToastUtil.show('验证码获取失败');
      _isCodeClickable = true;
      _codeHint = '获取验证码';
      setState(() {});
      return;
    }
    _getSmsCodeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _codeHint = '${60 - timer.tick}s后重新获取';
      if (timer.tick == 60) {
        _codeHint = '重发验证码';
        _isCodeClickable = true;
        timer.cancel();
        _getSmsCodeTimer = null;
      }
      setState(() {});
    });
  }

  _login() {
    var phone = _phoneController.text;
    var code = _codeController.text;
    if (phone.isEmpty) {
      ToastUtil.show('请输入手机号');
      return;
    }
    if (!_phoneRegex.hasMatch(phone)) {
      ToastUtil.show('手机号格式不正确');
      return;
    }
    if (code.isEmpty) {
      ToastUtil.show('请输入验证码');
      return;
    }
    _loging = true;
    setState(() {});
    Api.instance.login(phone, code).then((user) {
      context.read<UserProvider>().update(user);
      ToastUtil.show('登录成功');
      Navigator.of(context).pop();
    }).catchError((e) {
      ToastUtil.error(e);
    }).whenComplete(() {
      _loging = false;
      setState(() {});
    });
  }
}
