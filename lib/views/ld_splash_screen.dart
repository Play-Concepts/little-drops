import 'dart:async';

import 'package:drops/utils/ld_colors.dart';
import 'package:drops/views/ld_login_view.dart';
import 'package:flutter/material.dart';
import 'package:drops/utils/ld_style.dart';
import 'package:drops/utils/data_keys.dart';
import 'package:drops/views/ld_walk_through_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LDSplashScreen extends StatefulWidget {
  static String tag = '/LDSplashScreen';

  @override
  _LDSplashScreenState createState() => _LDSplashScreenState();
}

class _LDSplashScreenState extends State<LDSplashScreen>
    with SingleTickerProviderStateMixin {
  final GetStorage box = GetStorage(dkStore);
  startTime() async {
    var _duration = Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  void navigationPage() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool(dkSplash) ?? false) {
      Get.off(LDLoginView());
    } else {
      preferences.setBool(dkSplash, true);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LDWalkThroughView(),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    //final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ldPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Image.asset(
              'images/logo.png',
              height: 105,
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Text(
                "Little Drops",
                style: secondaryTextStyle(
                  size: 25,
                  textColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
