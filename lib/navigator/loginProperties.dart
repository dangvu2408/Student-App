import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hust_sa/main.dart';
import 'package:page_transition/page_transition.dart';
class loginActivity extends StatefulWidget {
    @override
    loginState createState() => loginState();
}

class loginState extends State<loginActivity> {
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
                    IntrinsicHeightScrollView(
                        child: Column(
                            children: [
                                Spacer(),
                                Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 35),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: BackdropFilter(
                                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                            child: Container(
                                                padding: const EdgeInsets.only(top: 10, bottom: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15.0),
                                                    border: Border.all(
                                                        width: 1.0,
                                                        color: Color.fromARGB(255, 255, 44, 65).withOpacity(.6),
                                                    ),
                                                ),
                                                child: Container(
                                                    padding: const EdgeInsets.only(left: 15, right: 15),
                                                    child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: <Widget>[
                                                            const Text(
                                                                'ĐĂNG NHẬP',
                                                                style: TextStyle(
                                                                    fontSize: 24,
                                                                    fontFamily: 'SFProBold',
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.w900,
                                                                ),
                                                            ),
                                                            Container(
                                                                height: 40,
                                                                margin: EdgeInsets.symmetric(vertical: 5),
                                                                child: TextField(
                                                                    decoration: InputDecoration(
                                                                        filled: true,
                                                                        fillColor: Colors.white,
                                                                        border: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.circular(10),
                                                                            borderSide: BorderSide.none,
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
                                                                    obscureText: true,
                                                                    decoration: InputDecoration(
                                                                        filled: true,
                                                                        fillColor: Colors.white,
                                                                        border: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.circular(10),
                                                                            borderSide: BorderSide.none,
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
                                                                                keyboardType: TextInputType.number,
                                                                                decoration: InputDecoration(
                                                                                    filled: true,
                                                                                    fillColor: Colors.white,
                                                                                    border: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                        borderSide: BorderSide.none,
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
                                                                        const Image(
                                                                            image: AssetImage('assets/images/captcha.png'),
                                                                        ),
                                                                        const Image(
                                                                            height: 20,
                                                                            width: 20,
                                                                            image: AssetImage('assets/images/repeat.png'),
                                                                        ),
                                                                    ],
                                                                )
                                                            ),
                                                            TextButton(
                                                                onPressed: () {
                                                                    Navigator.push(context, PageTransition(
                                                                        child: myWidget(title: 'HUST'),
                                                                        type: PageTransitionType.fade,
                                                                        duration: const Duration(milliseconds: 1000),
                                                                    ));
                                                                },
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
                                                                    'ĐĂNG NHẬP',
                                                                    style: TextStyle(
                                                                        fontSize: 20,
                                                                        fontFamily: 'SFProBold',
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.w900,
                                                                    ),
                                                                )
                                                            )
                                                        ],
                                                    )
                                                ),
                                            )
                                        ),
                                    ),
                                ),
                                Spacer(), Spacer(),
                                Container(
                                    padding: EdgeInsets.only(bottom: 30),
                                    child: const Text(
                                        'Bản Beta',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'SFPro',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                        ),
                                    ),
                                )
                            ],
                        )
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