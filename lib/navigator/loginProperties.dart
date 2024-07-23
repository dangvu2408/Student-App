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

  void initState() {
    super.initState();
    widget.ath.loadCaptcha(setState);
  }
  void confirmationDialog(BuildContext context) async {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: TextStyleExample(name : 'Privacy',style : textTheme.titleMedium!.copyWith(color: MyColors.black, fontWeight: FontWeight.bold)),
          title: const Text(
              'Xác nhận đăng nhập',
              style : TextStyle(
                fontSize: 20,
                fontFamily: 'SFProSemiBold',
              )
          ),
          content: const Text(
              "Khi bạn ấn nút \"TIẾP TỤC\", ứng dụng sẽ đăng nhập vào trang web ctt-sis.hust.edu.vn và ctsv.hust.edu.vn để lấy thông tin. Ứng dụng sẽ không lấy thêm thông tin nào khác. Tiếp tục đăng nhập?",
              style : TextStyle(
                fontSize: 16,
                fontFamily: 'SFProSemiBold',
              )
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                  'THOÁT',
                  style : TextStyle(
                    fontSize: 16,
                    fontFamily: 'SFProSemiBold',
                    color: Colors.black,
                  )
              ),
              //child: TextStyleExample(name : 'DISAGREE',style : textTheme.labelLarge!),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              // child: TextStyleExample(name : 'AGREE',style : textTheme.labelLarge!.copyWith(color: MyColors.accentDark)),
              child: const Text(
                  'TIẾP TỤC',
                  style : TextStyle(
                    fontSize: 16,
                    fontFamily: 'SFProSemiBold',
                    color: Colors.black,
                  )
              ),
              onPressed: () {
                widget.ath.login(setState, context);
              },
            )
          ],
        );
      },
    );
  }
  continueStep() {
    if (currentStep < 2) {
      setState(() {
        currentStep += 1;
      });
    } else {
      confirmationDialog(context);
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
              )),
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
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
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
            margin: EdgeInsets.only(top: statusBarHeight + 15, right: 25, bottom: 15, left: 25),
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
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 0.5),
                  blurRadius: 5.0,
                ),
              ],
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
                                    borderSide: BorderSide(
                                        width: 2, color: Color(0xFFD80015)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        width: 1, color: Color(0xFFD80015)),
                                  ),
                                  hintText: 'Mã số sinh viên',
                                  hintStyle: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'SFPro',
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10)),
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
                                    borderSide: BorderSide(
                                        width: 2, color: Color(0xFFD80015)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        width: 1, color: Color(0xFFD80015)),
                                  ),
                                  hintText: 'Mật khẩu',
                                  hintStyle: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'SFPro',
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10)),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Color(0xFFD80015)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xFFD80015)),
                                          ),
                                          hintText: 'Mã Captcha',
                                          hintStyle: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'SFPro',
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 10)),
                                    ),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(left: 15),
                                      padding: const EdgeInsets.only(right: 10),
                                      width: 130,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFD80015),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Stack(
                                        children: [
                                          if (widget.ath.captchaImageUrl !=
                                              null)
                                            Image.network(
                                                widget.ath.captchaImageUrl!),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                widget.ath
                                                    .loadCaptcha(setState);
                                              },
                                              child: const Image(
                                                height: 20,
                                                width: 20,
                                                image: AssetImage(
                                                    'assets/images/repeat.png'),
                                              ),
                                            ),
                                          )
                                        ],
                                      ))
                                ],
                              )),
                        ],
                      ),
                      isActive: currentStep >= 0,
                      state: currentStep >= 0
                          ? StepState.complete
                          : StepState.disabled),
                  Step(
                    title: const Text('Đăng nhập ctsv.hust.edu.vn'),
                    content: const Text(
                        'This is the 2 step.',
                        style : TextStyle(
                          fontSize: 18,
                          fontFamily: 'SFProSemiBold',
                          color: Colors.black,
                    )),
                    isActive: currentStep >= 0,
                    state: currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: const Text('Hoàn tất'),
                    content: const Text('Xác nhận thông tin đăng nhập.',
                      style : TextStyle(
                        fontSize: 18,
                        fontFamily: 'SFProSemiBold',
                        color: Colors.black,
                      ),
                    ),
                    isActive: currentStep >= 0,
                    state: currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ]),
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
