import 'package:drops/controllers/profile_controller.dart';
import 'package:drops/entities/child.dart';
import 'package:drops/entities/profile.dart';
import 'package:drops/views/ld_edit_child_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drops/utils/ld_colors.dart';
import 'package:drops/utils/ld_style.dart';
import 'package:drops/views/ld_edit_profile_view.dart';
import 'package:get/get.dart';

class LDProfileView extends StatelessWidget {
  final ProfileController profileController = Get.find<ProfileController>();

  String profileName(Profile profile) {
    if (profile == null || profile.data == null) return '';
    return profile.data.name;
  }

  String numberOfChildren(Iterable children) {
    if (children == null) return '0';
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
                    onTap: () => Get.to(LDEditProfileView()),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Children',
                            style: boldTextStyle(
                                textColor: Colors.black, size: 14),
                          ),
                          Container(
                            child: GestureDetector(
                              onTap: () => Get.to(LDEditChildView(), arguments: new Child(data: new ChildData(name: '', relationship: '')), preventDuplicates: true),
                              child: Icon(
                                Icons.add_circle,
                                color: ldSecondaryColorGreen,
                              )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: size.height - 320 - 40 - 90,
              margin: EdgeInsets.only(
                  top: 320.00 + 35, bottom: 25, left: 16, right: 16),
              padding: EdgeInsets.only(
                top: 5,
                left: 15,
                right: 15,
              ),
              decoration: boxDecorations(
                showShadow: true,
              ),
              child: Obx(() => ListView.builder(
                    padding: EdgeInsets.only(bottom: 16),
                    scrollDirection: Axis.vertical,
                    itemCount: profileController.children == null
                        ? 0
                        : profileController.children.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                          padding: EdgeInsets.only(top: 16, bottom: 16),
                          width: size.width,
                          decoration: boxDecorations(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                height: 45,
                                width: 45,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: FadeInImage(
                                    fit: BoxFit.cover,
                                    placeholder: AssetImage(
                                      'images/loading.png',
                                    ),
                                    image: Image.network(
                                      profileController.children[index].data ==
                                              null
                                          ? ''
                                          : profileController
                                              .children[index].data.image,
                                      height: 35,
                                      width: 10,
                                    ).image,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          profileController
                                                      .children[index].data ==
                                                  null
                                              ? ''
                                              : profileController
                                                  .children[index].data.name,
                                          style: boldTextStyle(size: 16),
                                        ),
                                        Container(
                                          child: GestureDetector(
                                            onTap: () => Get.to(LDEditChildView(), arguments: profileController.children[index], preventDuplicates: true),
                                            child: Icon(
                                              Icons.edit,
                                              color: ldSecondaryColorGreen,
                                            )
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Text(
                                        profileController
                                                    .children[index].data ==
                                                null
                                            ? ''
                                            : profileController.children[index]
                                                .data.relationship,
                                        style: secondaryTextStyle(size: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '',
                                style: boldTextStyle(),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
