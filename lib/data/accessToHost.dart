

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:crypto/crypto.dart';
import 'package:hust_sa/data/requestData.dart';
import 'package:hust_sa/navigator/loginProperties.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'package:hust_sa/data/sharedPreferences.dart';

class accessToHost {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController captchaController = TextEditingController();
    Uint8List? captchaImage;
    String? captchaImageUrl;
    String? viewState;
    String? eventValidation;
    String loginCode = '';
    Map<String, String> cookies = {};
    Map<String, String> cookiesEncrypt = {};
    Map<String, String> cookiesLogin = {};

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
                var setCookieHeader = response.headers['set-cookie'];
                this.cookiesLogin = Map.fromEntries(setCookieHeader!.split(';')
                    .map((cookie) => cookie.split('='))
                    .where((pair) => pair.length == 2)
                    .map((pair) => MapEntry(pair[0].trim(), pair[1].trim())));
                final document = htmlParser.parse(response.body);
                final captchaElement = document.getElementById('ctl00_ctl00_contentPane_MainPanel_MainContent_ASPxCaptcha1_IMG');
                if (captchaElement != null) {
                    final srcValue = captchaElement.attributes['src'];
                    if (srcValue != null) {
                        final viewStateElement = document.querySelector('input[id=__VIEWSTATE]');
                        final eventValidationElement = document.querySelector('input[id=__EVENTVALIDATION]');
                        if (viewStateElement != null && eventValidationElement != null) {
                            final viewState = viewStateElement.attributes['value'];
                            final eventValidation = eventValidationElement.attributes['value'];
                            if (viewState != null && eventValidation != null) {
                                // Lưu các giá trị vào SharedPreferences
                                setState(() {
                                    captchaImageUrl = 'https://ctt-sis.hust.edu.vn' + srcValue;
                                    this.viewState = viewState;
                                    this.eventValidation = eventValidation;
                                });
                                await setFormHidden(viewState, eventValidation);
                            } else {
                                _showToast('Lỗi: viewState hoặc eventValidation là null');
                            }
                        } else {
                            _showToast('Lỗi: Không tìm thấy phần tử viewState hoặc eventValidation');
                        }
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
        var loginSuccess = false;
        try {

            final encrypt = await http.get(Uri.parse('https://encode-decode.com/des-ecb-encrypt-online/'));
            _parseCookies(encrypt.headers);
            final encryptionDocument = htmlParser.parse(encrypt.body);
            final tokenElement = encryptionDocument.getElementById('encryption__token');

            if (tokenElement != null) {
                final token = tokenElement.attributes['value'];
                final encryptPOST = await http.post(
                    Uri.parse('https://encode-decode.com/des-ecb-encrypt-online/'),
                    headers: {
                        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
                        'Cookie': cookiesEncrypt.entries.map((e) => '${e.key}=${e.value}').join('; '),
                    },
                    body: {
                        'encryption[algorithm]': 'des-ecb',
                        'encryption[sourceText]': password,
                        'encryption[destinationText]': '',
                        'encryption[secret]': md5Hash,
                        'encryption[encrypt]': '',
                        'encryption[_token]': token,
                    },
                );

                final encryptionResultDocument = htmlParser.parse(encryptPOST.body);
                final encryptedPasswordElement = encryptionResultDocument.getElementById('encryption_destinationText');
                final encryptedPassword = encryptedPasswordElement?.text ?? '';

                loginCode = '{&quot;data&quot;:&quot;12|#|user|4|9|1' + username + 'pass|4|25|1' + encryptedPassword+ '#&quot;}';
                loginSuccess = await requestData().loginRequest(context, username, password, captcha, loginCode, this.cookiesLogin, 0);
                if (!loginSuccess) {
                    loginCode = '{&quot;data&quot;:&quot;12|#|user|4|9|1' + username + 'pass|4|45|1' + encryptedPassword+ '#&quot;}';
                    loginSuccess = await requestData().loginRequest(context, username, password, captcha, loginCode, this.cookiesLogin, 1);
                    if (!loginSuccess) {
                        loginCode = '{&quot;data&quot;:&quot;12|#|user|4|9|1' + username + 'pass|4|33|1' + encryptedPassword+ '#&quot;}';
                        loginSuccess = await requestData().loginRequest(context, username, password, captcha, loginCode, this.cookiesLogin, 2);
                        if (!loginSuccess) {
                            loginCode = '{&quot;data&quot;:&quot;12|#|user|4|9|1' + username + 'pass|4|57|1' + encryptedPassword+ '#&quot;}';
                            loginSuccess = await requestData().loginRequest(context, username, password, captcha, loginCode, this.cookiesLogin, 3);
                            if (!loginSuccess) {
                                loginCode = '{&quot;data&quot;:&quot;12|#|user|4|9|1' + username + 'pass|4|25|1' + encryptedPassword+ '#&quot;}';
                                loginSuccess = await requestData().loginRequest(context, username, password, captcha, loginCode, this.cookiesLogin, 4);
                            }
                        }
                    }
                }
            }
            print(loginSuccess);
            if (loginSuccess) {
                _saveUser();
                _showToast('Đăng nhập thành công!');
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => myWidget(title: 'HUST')),
                );
            } else {
                Fluttertoast.showToast(msg: 'Đăng nhập trang ctt-sis.hust.edu.vn thất bại. Vui lòng thử lại.');
                await loadCaptcha(setState);
            }
        } catch(e) {
            print('Lỗi hàm login: $e');
        }
    }


    Future<void> _saveUser() async {
        await saveUser(usernameController.text, passwordController.text);
    }

    void _parseCookies(Map<String, String> headers) {
        if (headers['set-cookie'] != null) {
            List<String> cookiesList = headers['set-cookie']!.split(';');
            for (var cookie in cookiesList) {
                var cookieParts = cookie.split('=');
                if (cookieParts.length == 2) {
                    cookiesEncrypt[cookieParts[0]] = cookieParts[1];
                }
            }
        }
    }
}