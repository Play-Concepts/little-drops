import 'package:drops/utils/data_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drops/utils/ld_colors.dart';
import 'package:drops/utils/ld_style.dart';
import 'package:get/get.dart';
import 'package:drops/controllers/hatters_controller.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class LDLoginView extends GetView<HattersController> {
  @override
  Widget build(BuildContext context) {
    changeStatusColor(ldAppBackground);
    return SafeArea(
      child: Scaffold(
        backgroundColor: ldAppBackground,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 12),
                SizedBox(
                  width: 274,
                  child: Text(
                    "Welcome to Little Drops",
                    textAlign: TextAlign.center,
                    style: titleStyle(),
                  ),
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: 312,
                  child: Text(
                    "Track, score and store stories your child has written. ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ldTextSubColor,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 36),
                GestureDetector(
                  onTap: () => this.loginOrSignup("login"),
                  child: Container(
                    width: 312,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Color(0xffbf62a2),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Sign In",
                              style: GoogleFonts.baloo(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                GestureDetector(
                  onTap: () => this.loginOrSignup("signup"),
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.baloo(
                      textStyle: TextStyle(
                        color: ldTextSubAccentColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Image.asset(
                  'images/welcome/main.png',
                  height: 200,
                  width: 225,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void dispose() {}

  void loginOrSignup(String action) async {
    GetStorage(dkStore).write(dkSignInAction, action);
    final actionUrl =
        action == 'login' ? controller.loginUrl() : controller.signupUrl();
    if (await canLaunch(actionUrl)) {
      launch(actionUrl);
    } else {
      Get.snackbar(
          'Unknown Login/Signup Error', 'Unable to reach PDA Services.',
          backgroundColor: ldSecondaryColorRed, colorText: ldTextTertiaryColor);
    }
  }
}
