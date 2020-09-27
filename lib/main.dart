import 'dart:async';

import 'package:drops/controllers/profile_controller.dart';
import 'package:drops/controllers/stories_controller.dart';
import 'package:drops/repositories/profile_repository.dart';
import 'package:drops/repositories/stories_repository.dart';
import 'package:drops/services/profile_service.dart';
import 'package:drops/services/stories_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:drops/views/ld_splash_screen.dart';
import 'package:drops/views/ld_home_page_view.dart';
import 'package:drops/utils/ld_colors.dart';
import 'package:drops/utils/data_keys.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' show Client;

import 'package:drops/services/hatters_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/hatters_controller.dart';
import 'package:uni_links/uni_links.dart';

void main() async {
  //FlutterError.onError = Crashlytics.instance.recordFlutterError;
  await GetStorage.init(dkStore);

  Get.lazyPut<Client>(() => Client());
  Get.lazyPut<HattersService>(() => HattersService());
  Get.lazyPut<HattersController>(() => HattersController());

  Get.lazyPut<StoriesService>(() => StoriesService());
  Get.lazyPut<StoriesRepository>(() => StoriesRepository());
  Get.lazyPut<StoriesController>(() => StoriesController());

  Get.lazyPut<ProfileService>(() => ProfileService());
  Get.lazyPut<ProfileRepository>(() => ProfileRepository());
  Get.lazyPut<ProfileController>(() => ProfileController());

  runApp(MyApp());
}

void retrievePreferences() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  GetStorage box = GetStorage(dkStore);
  box.erase();
  if (preferences.getString(dkPda) != null) box.write(dkPda, preferences.getString(dkPda));
  if (preferences.getString(dkToken) != null) box.write(dkToken, preferences.getString(dkToken));
}



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription _sub;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [
          Locale('en', ''),
        ],
        routes: <String, WidgetBuilder>{
          LDSplashScreen.tag: (BuildContext context) => LDSplashScreen()
        },
        title: 'Little DROPS',
        home: LDSplashScreen(),
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: SBehavior(),
            child: child,
          );
        });
  }

  @override
  initState() {
    super.initState();
    _sub = getLinksStream().listen((String link) {
      if (!mounted) return;
      setState(() {
        try {
          if (link != null) {
            Uri _latestUri = Uri.parse(link);
            if (_latestUri.queryParameters.containsKey('token')) {
              final token = _latestUri.queryParameters['token'];
              final pda = Get.find<HattersService>().extractPda(token);
              GetStorage(dkStore).write(dkToken, token);
              GetStorage(dkStore).write(dkPda, pda);
              Get.off(LDHomePageView());
            } else if (_latestUri.queryParameters.containsKey('error')) {
              Get.snackbar('Unable to create new PDA', _latestUri.queryParameters['error_reason'],
                  backgroundColor: ldSecondaryColorRed,
                  colorText: ldTextTertiaryColor);
            }
          }
        } on FormatException {}
      });
    }, onError: (Object err) {
      print(err.toString());
    });
  }


  @override
  dispose() {
    if (_sub != null) _sub.cancel();
    super.dispose();
  }
}

class SBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
