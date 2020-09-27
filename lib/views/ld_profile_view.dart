import 'package:drops/controllers/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drops/utils/ld_colors.dart';
import 'package:drops/utils/ld_style.dart';
import 'package:drops/views/ld_edit_profile_view.dart';
import 'package:drops/views/ld_profile_settings_view.dart';
import 'package:get/get.dart';

class LDProfileView extends StatefulWidget {
  @override
  _LDProfileViewState createState() => _LDProfileViewState();
}

class _LDProfileViewState extends State<LDProfileView> {
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(ldPrimaryColor);
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              height: 320,
              width: size.width,
              padding: EdgeInsets.only(top: 25, right: 10),
              color: ldPrimaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LDProfileSettingsView(),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    height: 80,
                    width: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: AssetImage(
                          'Loading',
                        ),
                        image: Image.network(
                          'https://i.insider.com/5de6dd81fd9db241b00c04d3?width=1100&format=jpeg&auto=webp',
                          height: 35,
                          width: 10,
                        ).image,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Obx(() => Text(
                          profileController.profile.value.data.name,
                          style: boldTextStyle(textColor: Colors.white),
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LDEditProfileView(),
                        ),
                      );
                    },
                    child: FittedBox(
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                        decoration: boxDecorations(
                          radius: 4,
                        ),
                        child: Center(
                          child: Text(
                            'Edit Profile',
                            style: boldTextStyle(
                                size: 12, textColor: ldPrimaryColor),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 320.00 - 50,
                      ),
                      padding: EdgeInsets.all(20),
                      decoration: boxDecoration(
                        radius: 8,
                        backGroundColor: Colors.white,
                        spreadRadius: 2,
                        blurRadius: 10,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Number of Children',
                            style: boldTextStyle(
                                textColor: Colors.black, size: 14),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '2',
                            style: boldTextStyle(
                              textColor: Colors.green.withOpacity(0.8),
                              size: 26,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 320.00 - 50,
                      ),
                      padding: EdgeInsets.all(20),
                      decoration: boxDecoration(
                          radius: 8,
                          backGroundColor: Colors.white,
                          spreadRadius: 2,
                          blurRadius: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Stories Created',
                            style: boldTextStyle(
                                textColor: Colors.black, size: 14),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '67',
                            style: boldTextStyle(
                              textColor:
                                  ldSecondaryColorYellow.withOpacity(0.7),
                              size: 26,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(
                    top: 320.00 + 100, bottom: 25, left: 16, right: 16),
                padding: EdgeInsets.only(
                  top: 5,
                  left: 15,
                  right: 15,
                ),
                decoration: boxDecorations(
                  showShadow: true,
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text('Completion Rate',
                              style: boldTextStyle(size: 16)),
                        ),
                        Container(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: 'Monthly',
                              items: <String>[
                                'Daily',
                                'Weekly',
                                'Monthly',
                                'Yearly'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(
                                    value,
                                    style: boldTextStyle(size: 16),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {},
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
