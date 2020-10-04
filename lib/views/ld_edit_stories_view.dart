import 'package:drops/controllers/profile_controller.dart';
import 'package:drops/controllers/stories_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drops/entities/SDExamCardModel.dart';
import 'package:drops/utils/ld_style.dart';
import 'package:drops/utils/ld_colors.dart';
import 'package:drops/utils/random_data.dart';
import 'package:drops/views/ld_edit_story_view.dart';
import 'package:get/get.dart';

RxString selectChildId = ''.obs;
RxString selectChildName = ''.obs;

SDExamCardModel card = SDExamCardModel(
  image: randomImage(),
  examName: 'Uriel Lee',
  time: 'Elder daughter',
  icon: Icon(
    Icons.notifications_active,
    color: Colors.white54,
  ),
  startColor: Color(0xFFEB550F),
  endColor: Color(0xFFFFA635),
);

final StoriesController storiesController = Get.find<StoriesController>();
final ProfileController profileController = Get.find<ProfileController>();

ImageProvider _storiesImageAsset(String location) {
  if (location == null) location = randomImage();
  return Image.asset(
    location,
    height: 35,
    width: 20,
  ).image;
}

void _getStoriesList(String childId, String childName) {
  storiesController.getStories(childId, editMode: true);
  selectChildId.value = childId;
  selectChildName.value = childName;
}

void _newStory() => Get.snackbar('title', 'message');

Widget LDEditStoriesView(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Container(
    padding: EdgeInsets.only(bottom: 16),
    width: size.width,
    child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 25, left: 16, bottom: 16),
              width: size.width,
              color: ldSecondaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Write Stories',
                    style: boldTextStyle(
                        size: 16, textColor: Colors.white, letterSpacing: 0.5),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      'Select a child.',
                      style: secondaryTextStyle(
                          size: 12, textColor: Colors.white.withOpacity(0.7)),
                    ),
                  )
                ],
              )),
          SizedBox(
            height: 15,
          ),
          Container(
              height: 250,
              child: Obx(() => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: profileController.children == null
                      ? 0
                      : profileController.children.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => _getStoriesList(
                          profileController.children[index].recordId,
                          profileController.children[index].data.name),
                      child: Container(
                        width: 170.0,
                        margin: EdgeInsets.only(
                          left: 16,
                        ),
                        padding: EdgeInsets.all(10),
                        decoration: boxDecoration(
                          radius: 8,
                          spreadRadius: 1,
                          blurRadius: 4,
                          gradient: LinearGradient(
                            colors: [card.startColor, card.endColor],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white30,
                              child: Image.asset(
                                randomImage(),
                                height: 60,
                                width: 60,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              profileController.children[index].data == null
                                  ? ''
                                  : profileController.children[index].data.name,
                              style: secondaryTextStyle(
                                  textColor: Colors.white, size: 20),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  profileController.children[index].data == null
                                      ? ''
                                      : profileController
                                          .children[index].data.relationship,
                                  style: secondaryTextStyle(
                                      textColor: Colors.white54, size: 18),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }))),
          SizedBox(
            height: 35,
          ),
          Container(
            padding: EdgeInsets.only(top: 16, left: 16, bottom: 16, right: 16),
            width: size.width,
            color: ldSecondaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Obx(() => Text(
                          selectChildName.value == ''
                              ? 'Select a Child.'
                              : 'Write for $selectChildName',
                          style: boldTextStyle(
                              size: 16,
                              textColor: Colors.white,
                              letterSpacing: 0.5),
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Obx(() => Text(
                            selectChildName.value == ''
                                ? ''
                                : 'Select a story to edit.',
                            style: secondaryTextStyle(
                                size: 12,
                                textColor: Colors.white.withOpacity(0.7)),
                          )),
                    )
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () => _newStory(),
                  child: Icon(
                    Icons.add_circle,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                primary: false,
                padding: EdgeInsets.only(bottom: 16),
                itemCount: storiesController.storiesEdit.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                    width: double.infinity,
                    decoration: boxDecorations(
                      showShadow: true,
                    ),
                    child: ListTile(
                      onTap: () {
                        storiesController.getStoryChapters(selectChildId.value,
                            storiesController.storiesEdit[index].recordId,
                            editMode: true);
                        Get.to(LDEditStoryView(
                            childId: selectChildId.value,
                            storyId:
                                storiesController.storiesEdit[index].recordId,
                            name:
                                storiesController.storiesEdit[index].data.title,
                            description: storiesController
                                .storiesEdit[index].data.description,
                            backgroundImages: storiesController
                                .storiesEdit[index].data.backgroundImages));
                      },
                      leading: Container(
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
                            image: _storiesImageAsset(storiesController
                                .storiesEdit[index].data.image),
                          ),
                        ),
                      ),
                      title: Text(
                        storiesController.storiesEdit[index].data.title,
                        style: boldTextStyle(size: 16),
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          storiesController.storiesEdit[index].data.description,
                          style: secondaryTextStyle(size: 10),
                        ),
                      ),
                    ),
                  );
                })),
          ),
        ]),
  );
}
