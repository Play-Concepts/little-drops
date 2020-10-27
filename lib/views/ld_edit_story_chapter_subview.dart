import 'package:drops/entities/story_chapter.dart';
import 'package:flutter/material.dart';
import 'package:drops/utils/ld_style.dart';
import 'package:drops/utils/ld_colors.dart';
import 'package:get/get.dart';

class LDEditStoryChapterSubview extends StatelessWidget {
  RxString updatedTitle = ''.obs;
  RxString updatedStory = ''.obs;
  Rx<StoryChapter> storyChapter = (new StoryChapter()).obs;

  void _commit() {
    if (updatedTitle.value!='') this.storyChapter.value.data.title = updatedTitle.value;
    if (updatedStory.value!='') this.storyChapter.value.data.story = updatedStory.value;
    Get.back(result: this.storyChapter);
  }

  @override
  Widget build(BuildContext context) {
    this.storyChapter = Get.arguments as Rx<StoryChapter>;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back, color: Colors.black),
          ),
          title: Text('Edit Story Section', style: boldTextStyle(size: 20)),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                decoration: boxDecorations(showShadow: true),
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.all(16.0),
                child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          initialValue: this.storyChapter.value.data.title,
                          onChanged: (newText) =>
                              updatedTitle.value = newText,
                          cursorColor: ldTextSecondaryColor.withOpacity(0.2),
                          cursorWidth: 1,
                          autocorrect: true,
                          autofocus: false,
                          decoration: InputDecoration(
                            hintText: 'Title of Story',
                            hintStyle: secondaryTextStyle(
                                textColor:
                                    ldTextSecondaryColor.withOpacity(0.6)),
                            border: const OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(
                                left: 16, bottom: 16, top: 16, right: 16),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          initialValue: this.storyChapter.value.data.story,
                          onChanged: (newText) => updatedStory.value = newText,
                          cursorColor: ldTextSecondaryColor.withOpacity(0.2),
                          cursorWidth: 1,
                          autocorrect: true,
                          autofocus: false,
                          keyboardType: TextInputType.multiline,
                          minLines: 5,
                          maxLines: 13,
                          decoration: InputDecoration(
                            hintText: 'Description of Story',
                            hintStyle: secondaryTextStyle(
                                textColor:
                                ldTextSecondaryColor.withOpacity(0.6)),
                            border: const OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(
                                left: 16, bottom: 16, top: 16, right: 16),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
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
                              FittedBox(
                                child: GestureDetector(
                                  onTap: () => _commit(),
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
                        )
                      ],
                    )),
              )
            ],
          ),
        )
      ),
    );
  }
}
