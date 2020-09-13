import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drops/entities/story.dart';
import 'package:drops/entities/SDExamCardModel.dart';
import 'package:drops/utils/ld_style.dart';
import 'package:drops/views/ld_story_view.dart';

List<Story> stories = [
  Story(
      image: 'images/sdearth.png',
      title: 'GeoGraphy',
      backgroundImages:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSePqEkOx6meh5aP5W0wRjvqCwDMFrpKyjFQA&usqp=CAU',
      description: 'Some story about ...'),
  Story(
      image: 'images/sdruler.png',
      title: 'Math',
      backgroundImages:
          'https://d2c7ipcroan06u.cloudfront.net/wp-content/uploads/2019/07/mathematics-696x364.jpg',
      description: 'Some Story about math'),
  Story(
      image: 'images/sdbiology.png',
      title: 'Biology',
      backgroundImages:
          'https://physicsworld.com/wp-content/uploads/2019/09/dna-binary-code-255618778-Shutterstock_ymgerman.jpg',
      description: 'Some story about biology'),
  Story(
      image: 'images/sdcomputer.png',
      title: 'Computer',
      backgroundImages:
          'https://previews.123rf.com/images/aleksander1/aleksander11302/aleksander1130200018/18017241-bulb-made-of-computer-subjects-.jpg',
      description: 'Some story about Computers'),
  Story(
      image: 'images/sdmusic.png',
      title: 'Music',
      backgroundImages:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSePqEkOx6meh5aP5W0wRjvqCwDMFrpKyjFQA&usqp=CAU',
      description: 'Some story about Music'),
  Story(
      image: 'images/sddance.png',
      title: 'Dance',
      backgroundImages:
          'https://i.pinimg.com/originals/30/45/9c/30459c328f5f535509d3131f773ab10f.jpg',
      description: 'Some story about Dance'),
];

List<SDExamCardModel> cards = [
  SDExamCardModel(
    image: 'images/sdbiology.png',
    examName: 'Biology final\nexams',
    time: '15 minutes',
    icon: Icon(
      Icons.notifications_active,
      color: Colors.white54,
    ),
    startColor: Color(0xFF2889EB),
    endColor: Color(0xFF0B56CB),
  ),
  SDExamCardModel(
    image: 'images/sdchemistry.png',
    examName: 'Chemistry daily\ntest',
    time: '15 minutes',
    icon: Icon(
      Icons.notifications_off,
      color: Colors.white54,
    ),
    startColor: Color(0xFFF1AD4B),
    endColor: Color(0xFFF26340),
  ),
  SDExamCardModel(
    image: 'images/sdmusic.png',
    examName: 'Music daily\nlearning',
    time: '3 hours',
    icon: Icon(
      Icons.notifications,
      color: Colors.white54,
    ),
    startColor: Color(0xFF7EA56C),
    endColor: Color(0xFF6C9258),
  )
];

Widget LDStoriesView(BuildContext context) {
  var name = 'Terry';
  return Container(
    child: SingleChildScrollView(
      padding: EdgeInsets.only(top: 20, bottom: 16),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                'Hi, $name',
                style: boldTextStyle(size: 20),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                'You have 3 exams pending',
                style: secondaryTextStyle(size: 14),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 250,
              child: ListView.builder(
                  padding: EdgeInsets.only(right: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: cards == null ? 0 : cards.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Container(
                        width: 180.0,
                        margin: EdgeInsets.only(
                          left: 16,
                        ),
                        padding: EdgeInsets.all(10),
                        decoration: boxDecoration(
                          radius: 8,
                          spreadRadius: 1,
                          blurRadius: 4,
                          gradient: LinearGradient(
                            colors: [
                              cards[index].startColor,
                              cards[index].endColor
                            ],
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
                                cards[index].image,
                                height: 60,
                                width: 60,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              cards[index].examName,
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
                                  cards[index].time,
                                  style: secondaryTextStyle(
                                      textColor: Colors.white54, size: 18),
                                ),
                                cards[index].icon
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                'Read Stories',
                style: boldTextStyle(size: 16),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                'Senior High School - 12th Grade',
                style: secondaryTextStyle(size: 14),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            ListView.builder(
                primary: false,
                padding: EdgeInsets.only(bottom: 16),
                itemCount: stories.length,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LDStoryView(
                                name: stories[index].title,
                                backgroundImages:
                                    stories[index].backgroundImages),
                          ),
                        );
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
                              'Loading',
                            ),
                            image: Image.asset(
                              stories[index].image,
                              height: 35,
                              width: 20,
                            ).image,
                          ),
                        ),
                      ),
                      title: Text(
                        stories[index].title,
                        style: boldTextStyle(size: 16),
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          stories[index].description,
                          style: secondaryTextStyle(size: 10),
                        ),
                      ),
                    ),
                  );
                }),
          ]),
    ),
  );
}
