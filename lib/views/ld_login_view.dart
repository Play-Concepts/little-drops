import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drops/utils/ld_colors.dart';
import 'package:drops/utils/ld_style.dart';
import 'package:get/get.dart';
import 'package:drops/controllers/hatters_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class LDLoginView extends GetWidget<HattersController> {
  final TextEditingController emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    changeStatusColor(ldAppBackground);
    return SafeArea(
      child: Scaffold(
        backgroundColor: ldAppBackground,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Welcome!',
                    style: boldTextStyle(size: 25),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: size.width,
                    decoration: boxDecorations(
                      showShadow: true,
                    ),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                            controller: emailTextController,
                            cursorColor: ldTextSecondaryColor.withOpacity(0.2),
                            cursorWidth: 1,
                            autocorrect: true,
                            autofocus: false,
                            decoration: InputDecoration(
                              hintText: 'Email Address',
                              hintStyle: secondaryTextStyle(
                                  textColor:
                                      ldTextSecondaryColor.withOpacity(0.6)),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 16, bottom: 16, top: 16, right: 16),
                            ),
                            keyboardType: TextInputType.emailAddress),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SDButton(
                    textContent: "SIGN IN",
                    onPressed: () =>
                        this.loginOrSignup(emailTextController.text),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                    'This application requires you to have a HAT Personal Data Account.\n\nEnter your email address. You will be redirected to your HAT PDA for authentication. Otherwise a HAT PDA will automatically be created for you.',
                    style: secondaryTextStyle(size: 16),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailTextController.dispose();
  }

  void loginOrSignup(String email) {
    controller.isRegistered('email', email).then((value) async {
      final hatName = '${value.hatName}.${value.hatCluster}';
      final loginUrl = controller.loginUrl(hatName);
      if (await canLaunch(loginUrl)) {
        launch(loginUrl);
      } else {
        Get.snackbar('Unknown Login Error', 'Unable to redirect to your PDA.',
            backgroundColor: ldSecondaryColorRed,
            colorText: ldTextTertiaryColor);
      }
    }).catchError((e) async {
      if (controller.isEmailValid(email)) {
        final signupUrl = controller.signupUrl(email);
        print('signupUrl = $signupUrl');

        if (await canLaunch(signupUrl)) {
          launch(signupUrl);
        } else {
          Get.snackbar('Unknown Login Error', 'Unable to redirect to your PDA.',
              backgroundColor: ldSecondaryColorRed,
              colorText: ldTextTertiaryColor);
        }
      } else {
        Get.snackbar('Invalid Email', 'That doesn\'t appear to be an email.',
            backgroundColor: ldSecondaryColorRed,
            colorText: ldTextTertiaryColor);
      }
    });
  }
}
