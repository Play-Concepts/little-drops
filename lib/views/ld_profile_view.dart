import 'package:drops/controllers/profile_controller.dart';
import 'package:drops/controllers/stories_controller.dart';
import 'package:drops/entities/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drops/utils/ld_colors.dart';
import 'package:drops/utils/ld_style.dart';
import 'package:drops/views/ld_edit_profile_view.dart';
import 'package:get/get.dart';

class LDProfileView extends StatelessWidget {
  final ProfileController profileController = Get.find<ProfileController>();
  final StoriesController storiesController = Get.find<StoriesController>();

  String profileName(Profile profile) {
    if (profile==null || profile.data==null) return '';
    return profile.data.name;
  }

  String numberOfChildren(Iterable children) {
    if (children==null) return '0';
    storiesController.getTotalStoriesCount(children.toList());
    return children.length.toString();
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
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    margin: EdgeInsets.only(top: 20),
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: AssetImage(
                          'images/loading.png',
                        ),
                        image: Image.network(
                          'https://i.insider.com/5de6dd81fd9db241b00c04d3?width=1100&format=jpeg&auto=webp',
                          height: 15,
                          width: 10,
                        ).image,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Obx(() => Text(
                          profileName(profileController.profile.value),
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
                          Obx(() => Text(
                            numberOfChildren(profileController.children),
                            style: boldTextStyle(
                              textColor: Colors.green.withOpacity(0.8),
                              size: 26,
                            ),
                          )),
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
                          Obx(() => Text(
                            storiesController.totalStoriesCount.toString(),
                            style: boldTextStyle(
                              textColor: ldSecondaryColorYellow.withOpacity(0.8),
                              size: 26,
                            ),
                          )),
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
