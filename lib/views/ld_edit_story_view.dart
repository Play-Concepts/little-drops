import 'dart:ui';

import 'package:drops/controllers/stories_controller.dart';
import 'package:drops/entities/story.dart';
import 'package:drops/entities/story_chapter.dart';
import 'package:drops/views/ld_edit_story_chapter_subview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drops/utils/ld_colors.dart';
import 'package:drops/utils/ld_style.dart';
import 'package:get/get.dart';

import 'ld_edit_story_title_subview.dart';

class LDEditStoryView extends GetView<StoriesController> {
  String childId;
  Rx<Story> story = (new Story()).obs;
  Function callback;

  LDEditStoryView({String childId, Rx<Story> story, Function callback}) {
    this.childId = childId;
    this.story = story;
    this.callback = callback;
    StoryData originalData = this.story.value.data as StoryData;
    this.story.value.originalData = originalData.clone();
  }

  void _editTitle() => Get.to(LDEditStoryTitleSubview(), arguments: this.story);
  void _addSection() async {
    int index = controller.storyChaptersEdit.length + 1;
    StoryChapter storyChapter = StoryChapter(
        endpoint: "",
        recordId: "",
        data: StoryChapterData(title: "", story: "", index: index));
    storyChapter.originalData = storyChapter.data.clone();

    final result = await Get.to(LDEditStoryChapterSubview(), arguments: storyChapter.obs);
    if (result!=null)
      controller.storyChaptersEdit.add((result as Rx<StoryChapter>).value);
  }

  void _editSection(StoryChapter storyChapter) {
    StoryChapterData originalData = storyChapter.data as StoryChapterData;
    storyChapter.originalData = originalData.clone();
    Get.to(LDEditStoryChapterSubview(), arguments: storyChapter.obs);
  }

  void _upsertStory() async {
    // Update
    Story _story = this.story.value;
    String _storyId = null;
    if (_story.recordId!='') {
      _storyId = _story.recordId;
      if (_story.isDirty) {
        await controller.updateStory(this.childId, _story.recordId, _story.data.title, _story.data.description);
      }
    } else {
      Story savedStory = await controller.saveStory(this.childId, _story.data.title, _story.data.description);
      _storyId = savedStory.recordId;
    }

    controller.storyChaptersEdit.forEach((item) async {
      StoryChapter _chapter = item as StoryChapter;
      if (_chapter.recordId!='') {
        if (_chapter.isDirty) {
          await controller.updateStoryChapter(
              this.childId, _storyId, _chapter.recordId, _chapter.data.title,
              _chapter.data.story, _chapter.data.index);
        }
      } else {
        await controller.saveStoryChapter(this.childId, _storyId, _chapter.data.title, _chapter.data.story, _chapter.data.index);
      }
    });

    if (this.callback != null) this.callback();
    Get.back();
  }

  void _deleteStory() {
    Get.defaultDialog(
        title: 'Are you sure?',
        middleText: 'This story will be deleted permanently.',
        onConfirm: _doDeleteStory,
        textConfirm: 'Yes',
        confirmTextColor: ldTextTertiaryColor,
        onCancel: () => Get.back(),
        textCancel: 'No',
        cancelTextColor: ldSecondaryColorYellow,
        buttonColor: ldSecondaryColorYellow);
  }

  void _doDeleteStory() {
    controller.deleteStory(this.childId, this.story.value.recordId);
    Get.back(closeOverlays: true);
    Get.snackbar('Success!', 'Story Deleted.',
        backgroundColor: ldSecondaryColorGreen, colorText: ldTextTertiaryColor);
  }

  void _cancel() {
    this.story.value.data = this.story.value.originalData;
    if (this.callback != null) this.callback();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    height: 270,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: this.story.value.data.backgroundImages == null
                              ? NetworkImage(
                                  "https://d2rdhxfof4qmbb.cloudfront.net/wp-content/uploads/20190816134243/Desert-sand-sunset.jpg")
                              : NetworkImage(
                                  this.story.value.data.backgroundImages),
                          fit: BoxFit.cover),
                    ),
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          padding: EdgeInsets.only(top: 22, left: 20),
                          width: size.width,
                          color: Colors.grey.withOpacity(0.1),
                          child: Obx(() => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 100),
                                    child: Text(
                                      this.story.value.data.title ?? '',
                                      style: boldTextStyle(
                                          textColor: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: Text(
                                      this.story.value.data.description ?? '',
                                      style: secondaryTextStyle(
                                          textColor:
                                              Colors.white.withOpacity(0.8)),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(right: 15),
                                        child: GestureDetector(
                                            onTap: () => _editTitle(),
                                            child: Icon(
                                              Icons.edit,
                                              color: ldSecondaryColorYellow,
                                            )),
                                      )
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Obx(() => Container(
                    margin: EdgeInsets.only(top: 35, left: 15, right: 15),
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListView.builder(
                          itemCount: controller.storyChaptersEdit == null
                              ? 0
                              : controller.storyChaptersEdit.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              child: Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                controller
                                                    .storyChaptersEdit[index]
                                                    .data
                                                    .title,
                                                style: boldTextStyle(size: 24),
                                              ),
                                              GestureDetector(
                                                onTap: () => _editSection(
                                                    controller
                                                            .storyChaptersEdit[
                                                        index]),
                                                child: Icon(
                                                  Icons.edit,
                                                  color: ldSecondaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 8, bottom: 5),
                                            child: Text(
                                              controller
                                                  .storyChaptersEdit[index]
                                                  .data
                                                  .story,
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              style: primaryTextStyle(size: 18),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FittedBox(
                              child: GestureDetector(
                                onTap: () => _addSection(),
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                                  decoration: boxDecorations(
                                      radius: 4, bgColor: ldSecondaryColor),
                                  child: Center(
                                    child: Text('Add Section',
                                        style: boldTextStyle(
                                            size: 12, textColor: Colors.white)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  )),
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
                  onTap: () => _cancel(),
                  child: Text('Cancel', style: secondaryTextStyle()),
                ),
                GestureDetector(
                  onTap: () => _deleteStory(),
                  child: Text('Delete Story', style: warningTextStyle()),
                ),
                FittedBox(
                  child: GestureDetector(
                    onTap: () => _upsertStory(),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                      decoration:
                          boxDecorations(radius: 4, bgColor: ldSecondaryColor),
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
