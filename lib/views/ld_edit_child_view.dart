import 'package:drops/controllers/profile_controller.dart';
import 'package:drops/controllers/stories_controller.dart';
import 'package:drops/entities/child.dart';
import 'package:flutter/material.dart';
import 'package:drops/utils/ld_style.dart';
import 'package:drops/utils/ld_colors.dart';
import 'package:get/get.dart';

class LDEditChildView extends GetView<ProfileController> {
  Rx<Child> updatedChild = (new Child()).obs;
  String _childName(Child child) =>
      (child == null || child.data == null) ? '' : child.data.name;

  String _childRelationship(Child child) =>
      (child == null || child.data == null) ? '' : child.data.relationship;

  void _updateChild() {
    Child child = updatedChild.value;
    if (child.isDirty) {
      if (child.recordId==null) {
        controller.saveChild(child.data.name,
            relationship: child.data.relationship,
            onSuccess: () => displaySuccessMessage('Child Added.')
        );
      } else {
        controller.updateChild(child.recordId,
            child.data.name,
            relationship: child.data.relationship,
            onSuccess: () => displaySuccessMessage('Child Updated.')
        );
      }
    } else {
      return Get.back();
    }
    //if (updatedChildName.value == '') return Get.back();
   /* controller.updateProfile(
        controller.profile.value.recordId, updatedChildName.value,
        onSuccess: () => Get.back());*/
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
    Get.find<StoriesController>().reset();
    displaySuccessMessage('Child Deleted.');
  }

  void displaySuccessMessage(String message, {String title: "Success!"}) {
    Get.back(closeOverlays: true);
    Get.snackbar(title, message,
        backgroundColor: ldSecondaryColorGreen, colorText: ldTextTertiaryColor);
  }

  Widget EditField(Child child, String placeholder, Function initialValueFunction, Function valueChangeFunction) {
    return TextFormField(
      initialValue: initialValueFunction(child),
      onChanged: valueChangeFunction,
      cursorColor: ldTextSecondaryColor.withOpacity(0.2),
      cursorWidth: 1,
      autocorrect: true,
      autofocus: false,
      decoration: InputDecoration(
        hintText: placeholder,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    updatedChild.value = Get.arguments as Child;
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
              SizedBox(height: 20),
              Container(
                decoration: boxDecorations(showShadow: true),
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.all(16.0),
                child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        EditField(updatedChild.value, 'Name', _childName, (newValue)
                        {
                          updatedChild.value.data.name = newValue;
                          updatedChild.value.isDirty = true;
                        }),
                        EditField(updatedChild.value, 'Relationship', _childRelationship, (newValue)
                        {
                          updatedChild.value.data.relationship = newValue;
                          updatedChild.value.isDirty = true;
                        }),
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
