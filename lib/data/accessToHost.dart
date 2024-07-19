

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:crypto/crypto.dart';
import 'package:hust_sa/navigator/loginProperties.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class accessToHost {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController captchaController = TextEditingController();
    Uint8List? captchaImage;
    String? captchaImageUrl;
    String? viewState;
    String? eventValidation;
    Map<String, String> cookies = {};

    void _showToast(String message) {
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
        );
    }

    Future<void> loadCaptcha(Function setState) async {
        try {
            final response = await http.get(Uri.parse('https://ctt-sis.hust.edu.vn/Account/Login.aspx'));
            if (response.statusCode == 200) {
                final document = htmlParser.parse(response.body);
                final captchaElement = document.getElementById('ctl00_ctl00_contentPane_MainPanel_MainContent_ASPxCaptcha1_IMG');
                if (captchaElement != null) {
                    final srcValue = captchaElement.attributes['src'];
                    if (srcValue != null) {
                        setState(() {
                            captchaImageUrl = 'https://ctt-sis.hust.edu.vn' + srcValue;
                            viewState = document.getElementById('__VIEWSTATE')?.attributes['value'];
                            eventValidation = document.getElementById('__EVENTVALIDATION')?.attributes['value'];
                        });
                    } else {
                        _showToast('Lỗi: src của phần tử captcha là null');
                    }
                } else {
                    _showToast('Lỗi: src của phần tử captcha là null');
                }
            } else {
                _showToast('Lỗi tải captcha');
            }
        } catch (e) {
            _showToast('Lỗi: $e');
        }
    }

    String _md5(String input) {
        var bytes = utf8.encode(input);
        var digest = md5.convert(bytes);
        return digest.toString();
    }

    Future<void> login(Function setState, BuildContext context) async {
        print('Username: ${usernameController.text}');
        print('Password: ${passwordController.text}');
        print('Captcha: ${captchaController.text}');
        if (usernameController.text.isEmpty ||
                passwordController.text.isEmpty ||
                captchaController.text.isEmpty) {
            Fluttertoast.showToast(msg: 'Vui lòng điền vào trường còn thiếu');
            return;
        }

        final username = usernameController.text;
        final password = passwordController.text;
        final captcha = captchaController.text;
        final md5Hash = _md5('$username.$password');
        final loginData = {
            'ma_hoa': md5Hash,
            'username': username,
            'password': password,
            'captcha': captcha,
        };

        final success = await _performLogin(loginData);


        if (success) {
            _saveUser();
            _showToast('Đăng nhập thành công!');
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => myWidget(title: 'HUST')),
            );
        } else {
            _showToast('Đăng nhập thất bại!');
            await loadCaptcha(setState);
        }
    }

    Future<bool> _performLogin(Map<String, String> loginData) async {
        try {
            final response = await http.post(
                Uri.parse('https://ctt-sis.hust.edu.vn/Account/Login.aspx'),
                body: loginData,
            );
            print('Response status: ${response.statusCode}');
            print('Response body: ${response.body}');
            return response.statusCode == 200;
        } catch (e) {
            print('Lỗi: $e');
            return false;
        }
    }

    Future<void> _saveUser() async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', usernameController.text);
        await prefs.setString('password', passwordController.text);
    }
}