import 'package:drops/controllers/profile_controller.dart';
import 'package:drops/entities/child.dart';
import 'package:flutter/material.dart';
import 'package:drops/utils/ld_style.dart';
import 'package:drops/utils/ld_colors.dart';
import 'package:get/get.dart';

class LDEditChildView extends GetView<ProfileController> {
  RxString updatedChildName = ''.obs;

  String _childName(Child child) =>
      (child == null || child.data == null) ? '' : child.data.name;

  void _updateChild() {
    if (updatedChildName.value == '') return Get.back();
    controller.updateProfile(
        controller.profile.value.recordId, updatedChildName.value,
        onSuccess: () => Get.back());
  }
  void _deleteChild() {
    Child child = Get.arguments as Child;
    Get.defaultDialog(
        title: 'Are you sure?',
        middleText: 'This child and its associated stories will be deleted permanently.',
        onConfirm: () => _doDeleteChild(child.recordId),
        textConfirm: 'Yes',
        confirmTextColor: ldTextTertiaryColor,
        onCancel: () => Get.back(),
        textCancel: 'No',
        cancelTextColor: ldPrimaryColor,
        buttonColor: ldPrimaryColor);
  }

  void _doDeleteChild(String recordId) {
    controller.deleteChild(recordId);
    Get.back(closeOverlays: true);
    Get.snackbar('Success!', 'Story Deleted.',
        backgroundColor: ldSecondaryColorGreen, colorText: ldTextTertiaryColor);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back, color: Colors.black),
          ),
          title: Text('Edit Child', style: boldTextStyle(size: 20)),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(
                      'https://i.insider.com/5de6dd81fd9db241b00c04d3?width=1100&format=jpeg&auto=webp')),
              FittedBox(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                  decoration:
                      boxDecorations(radius: 4, bgColor: ldPrimaryColor),
                  child: Center(
                    child: Text('Change Child Photo',
                        style:
                            boldTextStyle(size: 12, textColor: Colors.white)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: boxDecorations(showShadow: true),
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.all(16.0),
                child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          initialValue: _childName(Get.arguments as Child),
                          onChanged: (newText) =>
                              updatedChildName.value = newText,
                          cursorColor: ldTextSecondaryColor.withOpacity(0.2),
                          cursorWidth: 1,
                          autocorrect: true,
                          autofocus: false,
                          decoration: InputDecoration(
                            hintText: 'Name',
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
                        ),
                      ],
                    ),
              )
            ],
          ),
        ),
        persistentFooterButtons: <Widget>[
          Container(
            height: 50,
            padding: EdgeInsets.only(left: 15, right: 15),
            width: MediaQuery.of(context).copyWith().size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Text('Cancel', style: secondaryTextStyle()),
                ),
                GestureDetector(
                  onTap: () => _deleteChild(),
                  child: Text('Delete Child', style: warningTextStyle()),
                ),
                FittedBox(
                  child: GestureDetector(
                    onTap: () => _updateChild(),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                      decoration:
                          boxDecorations(radius: 4, bgColor: ldPrimaryColor),
                      child: Center(
                        child: Text('Save',
                            style: boldTextStyle(
                                size: 12, textColor: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
