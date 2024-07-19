import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hust_sa/main.dart';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hust_sa/data/accessToHost.dart';
class loginActivity extends StatefulWidget {

    final accessToHost ath;
    loginActivity(this.ath);
    @override
    loginState createState() => loginState();
}

class loginState extends State<loginActivity> {
    int currentStep = 0;
    accessToHost host = accessToHost();
    // TextEditingController usernameController = TextEditingController();
    // TextEditingController passwordController = TextEditingController();
    // TextEditingController captchaController = TextEditingController();
    // Uint8List? captchaImage;
    // String? captchaImageUrl;
    // String? viewState;
    // String? eventValidation;
    // Map<String, String> cookies = {};
    void initState() {
        super.initState();
        widget.ath.loadCaptcha(setState);
    }

    continueStep() {
        if (currentStep < 2) {
            setState(() {
                currentStep += 1;
            });
        }
        else {
            widget.ath.login(setState, context);
        }
    }
    cancelStep() {
        if (currentStep > 0) {
            setState(() {
                currentStep = currentStep - 1; //currentStep-=1;
            });
        }
    }
    onStepTapped(int value) {
        setState(() {
            currentStep = value;
        });
    }

    Widget controlBuilders(context, details) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                children: [
                    OutlinedButton(
                        onPressed: details.onStepCancel,
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                        color: Color(0xFFD80015),
                                        width: 2.0,
                                    ),
                                ),
                            ),
                        ),
                        child: const Text(
                            'Quay lại',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'SFPro',
                                color: Colors.black,
                            ),
                        )
                    ),
                    Spacer(),
                    ElevatedButton(
                        onPressed: details.onStepContinue,
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                        color: Color(0xFFD80015),
                                        width: 2.0,
                                    ),
                                ),
                            ),
                        ),
                        child: const Text(
                            'Tiếp tục',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'SFPro',
                                color: Colors.black,
                            ),
                        )
                    ),
                ],
            ),
        );
    }

    // void _showToast(String message) {
    //     Fluttertoast.showToast(
    //         msg: message,
    //         toastLength: Toast.LENGTH_LONG,
    //         gravity: ToastGravity.BOTTOM,
    //     );
    // }
    //
    // Future<void> loadCaptcha() async {
    //     try {
    //         final response = await http.get(Uri.parse('https://ctt-sis.hust.edu.vn/Account/Login.aspx'));
    //         if (response.statusCode == 200) {
    //             final document = htmlParser.parse(response.body);
    //             final captchaElement = document.getElementById('ctl00_ctl00_contentPane_MainPanel_MainContent_ASPxCaptcha1_IMG');
    //             if (captchaElement != null) {
    //                 final srcValue = captchaElement.attributes['src'];
    //                 if (srcValue != null) {
    //                     setState(() {
    //                         captchaImageUrl = 'https://ctt-sis.hust.edu.vn' + srcValue;
    //                         viewState = document.getElementById('__VIEWSTATE')?.attributes['value'];
    //                         eventValidation = document.getElementById('__EVENTVALIDATION')?.attributes['value'];
    //                     });
    //                 } else {
    //                     _showToast('Lỗi: src của phần tử captcha là null');
    //                 }
    //             } else {
    //                 _showToast('Không tìm thấy phần tử captcha');
    //             }
    //         } else {
    //             _showToast('Lỗi tải captcha');
    //         }
    //     } catch (e) {
    //         _showToast('Error: $e');
    //     }
    // }
    //
    // String _md5(String input) {
    //     var bytes = utf8.encode(input);
    //     var digest = md5.convert(bytes);
    //     return digest.toString();
    // }
    //
    // Future<void> login() async {
    //     if (usernameController.text.isEmpty ||
    //         passwordController.text.isEmpty ||
    //         captchaController.text.isEmpty) {
    //         Fluttertoast.showToast(msg: 'Vui lòng điền vào trường còn thiếu');
    //         return;
    //     }
    //
    //     final username = usernameController.text;
    //     final password = passwordController.text;
    //     final captcha = captchaController.text;
    //     final md5Hash = _md5('$username.$password');
    //     final loginData = {
    //         'ma_hoa': md5Hash,
    //         'username': username,
    //         'password': password,
    //         'captcha': captcha,
    //     };
    //
    //     final success = await _performLogin(loginData);
    //
    //     Navigator.of(context).pop();
    //
    //     if (success) {
    //         _saveUser();
    //         _showToast('Đăng nhập thành công!');
    //         Navigator.pushReplacement(
    //             context,
    //             MaterialPageRoute(builder: (context) => myWidget(title: 'HUST')),
    //         );
    //     } else {
    //         _showToast('Đăng nhập thất bại!');
    //         await loadCaptcha();
    //     }
    // }
    //
    // Future<bool> _performLogin(Map<String, String> loginData) async {
    //     try {
    //         final response = await http.post(
    //             Uri.parse('https://ctt-sis.hust.edu.vn/Account/Login.aspx'),
    //             body: loginData,
    //         );
    //         return response.statusCode == 200;
    //     } catch (e) {
    //         return false;
    //     }
    // }
    //
    // Future<void> _saveUser() async {
    //     final prefs = await SharedPreferences.getInstance();
    //     await prefs.setString('username', usernameController.text);
    //     await prefs.setString('password', passwordController.text);
    // }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
                children: [
                    const SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: Image(
                            image: AssetImage('assets/images/homebackground.png'),
                            fit: BoxFit.cover,
                        ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 40, right: 25, bottom: 15, left: 25),
                        child: Container(
                            height: 40,
                            child: const Image(
                                image: AssetImage('assets/images/logofull.png'),
                            ),
                        ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 100, left: 15, right: 15),
                        decoration: const BoxDecoration(
                            color: Color(0xFFF8F9FD),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0), bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0),),
                            boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 0.5), blurRadius: 5.0,),],
                        ),
                        child: Stepper(
                            elevation: 0,
                            controlsBuilder: controlBuilders,
                            type: StepperType.vertical,
                            physics: const ScrollPhysics(),
                            onStepTapped: onStepTapped,
                            onStepContinue: continueStep,
                            onStepCancel: cancelStep,
                            currentStep: currentStep,
                            connectorColor: MaterialStateProperty.all(Color(0xFFD80015)),
                            steps: [
                                Step(
                                    title: const Text('Đăng nhập ctt-sis.hust.edu.vn'),
                                    content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                            Container(
                                                height: 40,
                                                margin: EdgeInsets.symmetric(vertical: 5),
                                                child: TextField(
                                                    controller: widget.ath.usernameController,
                                                    decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                        focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10),
                                                            borderSide: BorderSide(width: 2, color: Color(0xFFD80015)),
                                                        ),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10),
                                                            borderSide: BorderSide(width: 1,color: Color(0xFFD80015)),
                                                        ),
                                                        hintText: 'Mã số sinh viên',
                                                        hintStyle: const TextStyle(
                                                            fontSize: 16,
                                                            fontFamily: 'SFPro',
                                                        ),
                                                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10)
                                                    ),
                                                ),
                                            ),
                                            Container(
                                                height: 40,
                                                margin: EdgeInsets.symmetric(vertical: 5),
                                                child: TextField(
                                                    controller: widget.ath.passwordController,
                                                    obscureText: true,
                                                    decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                        focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10),
                                                            borderSide: BorderSide(width: 2, color: Color(0xFFD80015)),
                                                        ),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10),
                                                            borderSide: BorderSide(width: 1,color: Color(0xFFD80015)),
                                                        ),
                                                        hintText: 'Mật khẩu',
                                                        hintStyle: const TextStyle(
                                                            fontSize: 16,
                                                            fontFamily: 'SFPro',
                                                        ),
                                                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10)
                                                    ),
                                                ),
                                            ),
                                            Container(
                                                height: 40,
                                                margin: EdgeInsets.symmetric(vertical: 5),
                                                child: Row(
                                                    children: [
                                                        Expanded(
                                                            child: TextField(
                                                                controller: widget.ath.captchaController,
                                                                keyboardType: TextInputType.number,
                                                                decoration: InputDecoration(
                                                                    filled: true,
                                                                    fillColor: Colors.white,
                                                                    focusedBorder: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        borderSide: BorderSide(width: 2, color: Color(0xFFD80015)),
                                                                    ),
                                                                    enabledBorder: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        borderSide: BorderSide(width: 1,color: Color(0xFFD80015)),
                                                                    ),
                                                                    hintText: 'Mã Captcha',
                                                                    hintStyle: const TextStyle(
                                                                        fontSize: 16,
                                                                        fontFamily: 'SFPro',
                                                                    ),
                                                                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10)
                                                                ),
                                                            ),
                                                        ),
                                                        Container(
                                                            margin: const EdgeInsets.only(left: 15),
                                                            padding: const EdgeInsets.only(right: 10),
                                                            width: 130,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                color: Color(0xFFD80015),
                                                                borderRadius: BorderRadius.circular(10)
                                                            ),
                                                            child: Stack(
                                                                children: [
                                                                    if (widget.ath.captchaImageUrl != null)
                                                                        Image.network(widget.ath.captchaImageUrl!),
                                                                    Align(
                                                                        alignment: Alignment.centerRight,
                                                                        child: GestureDetector(
                                                                            onTap: () {
                                                                                widget.ath.loadCaptcha(setState);
                                                                            },
                                                                            child: const Image(
                                                                                height: 20,
                                                                                width: 20,
                                                                                image: AssetImage('assets/images/repeat.png'),
                                                                            ),
                                                                        ),
                                                                    )
                                                                ],
                                                            )
                                                        )
                                                    ],
                                                )
                                            ),
                                        ],
                                    ),
                                    isActive: currentStep >= 0,
                                    state: currentStep >= 0 ? StepState.complete : StepState.disabled),
                                Step(
                                    title: const Text('Đăng nhập ctsv.hust.edu.vn'),
                                    content: const Text('This is the 2 step.'),
                                    isActive: currentStep >= 0,
                                    state: currentStep >= 1 ? StepState.complete : StepState.disabled,
                                ),
                                Step(
                                    title: const Text('Hoàn tất'),
                                    content: const Text('This is the 3 step.'),
                                    isActive: currentStep >= 0,
                                    state: currentStep >= 2 ? StepState.complete : StepState.disabled,
                                ),
                            ]
                        ),
                    )
                ],
            ),
        );
    }
}

final class IntrinsicHeightScrollView extends StatelessWidget {
    const IntrinsicHeightScrollView({
        required this.child,
        Key? key,
    }) : super(key: key);
    final Widget child;
    @override
    Widget build(BuildContext context) {
        return LayoutBuilder(
            builder: (context, constraint) {
                return SingleChildScrollView(
                    child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: constraint.maxHeight),
                        child: IntrinsicHeight(
                            child: child,
                        ),
                    ),
                );
            },
        );
    }
}