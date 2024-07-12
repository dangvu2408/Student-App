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
    int currentStep = 0;
    continueStep() {
        if (currentStep < 2) {
            setState(() {
                currentStep += 1;
            });
        }
        else {
            Navigator.push(context, PageTransition(
                child: myWidget(title: 'HUST'),
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 500),
            ));
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
                                    content: const Text('This is the 1 step.'),
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