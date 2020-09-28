import 'package:flutter/material.dart';
import 'package:drops/entities/ScoreboardAvailableModel.dart';
import 'package:drops/utils/ld_colors.dart';
import 'package:drops/utils/ld_style.dart';
import 'package:drops/views/ld_edit_story_view.dart';

class LDEditStoriesView extends StatefulWidget {
  @override
  _LDEditStoriesViewState createState() =>
      _LDEditStoriesViewState();
}

class _LDEditStoriesViewState
    extends State<LDEditStoriesView>
    with SingleTickerProviderStateMixin {

  List<ScoreboardModel> scoreboardAvailable = [
    ScoreboardModel(
        image: 'images/sdbiology.png',
        title: 'Biology',
        subtitle: 'Ongoing',
        status: 0.8,
        backgroundImages:
            'https://physicsworld.com/wp-content/uploads/2019/09/dna-binary-code-255618778-Shutterstock_ymgerman.jpg'),
    ScoreboardModel(
      image: 'images/sdmusic.png',
      title: 'Music',
      subtitle: 'Available on 3:20 PM',
      status: 0.5,
      backgroundImages:
          'https://us.123rf.com/450wm/9dreamstudio/9dreamstudio1803/9dreamstudio180300671/96741197-work-desk-of-modern-composer-music-notes-near-headphones-on-dark-wooden-background-top-view-.jpg?ver=6',
    ),
    ScoreboardModel(
        image: 'images/sdcomputer.png',
        title: 'Computer',
        subtitle: 'Available on 5:30 PM',
        status: 0.2,
        backgroundImages:
            'https://previews.123rf.com/images/aleksander1/aleksander11302/aleksander1130200018/18017241-bulb-made-of-computer-subjects-.jpg'),
    ScoreboardModel(
        image: 'images/sdbiology.png',
        title: 'Biology',
        subtitle: 'Ongoing',
        status: 0.8,
        backgroundImages:
            'https://physicsworld.com/wp-content/uploads/2019/09/dna-binary-code-255618778-Shutterstock_ymgerman.jpg'),
    ScoreboardModel(
      image: 'images/sdmusic.png',
      title: 'Music',
      subtitle: 'Available on 3:20 PM',
      status: 0.5,
      backgroundImages:
          'https://us.123rf.com/450wm/9dreamstudio/9dreamstudio1803/9dreamstudio180300671/96741197-work-desk-of-modern-composer-music-notes-near-headphones-on-dark-wooden-background-top-view-.jpg?ver=6',
    ),
    ScoreboardModel(
        image: 'images/sdcomputer.png',
        title: 'Computer',
        subtitle: 'Available on 5:30 PM',
        status: 0.2,
        backgroundImages:
            'https://previews.123rf.com/images/aleksander1/aleksander11302/aleksander1130200018/18017241-bulb-made-of-computer-subjects-.jpg'),
  ];

  List<ScoreboardModel> scoreboardPassed = [
    ScoreboardModel(
        image: 'images/sdearth.png',
        title: 'Geography',
        subtitle: 'Available on 3:20',
        status: 70,
        backgroundImages:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSePqEkOx6meh5aP5W0wRjvqCwDMFrpKyjFQA&usqp=CAU'),
    ScoreboardModel(
      image: 'images/sddance.png',
      title: 'Dance',
      subtitle: '22/09/2019 at 2:20 PM',
      status: 100,
      backgroundImages:
          'https://i.pinimg.com/originals/30/45/9c/30459c328f5f535509d3131f773ab10f.jpg',
    ),
    ScoreboardModel(
        image: 'images/sdruler.png',
        title: 'Math',
        subtitle: '22/09/2019 at 2:20 PM',
        status: 30,
        backgroundImages:
            'https://d2c7ipcroan06u.cloudfront.net/wp-content/uploads/2019/07/mathematics-696x364.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(top: 25, left: 16, bottom: 16),
            width: size.width,
            color: ldPrimaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Write Stories',
                  style: boldTextStyle(
                      size: 18, textColor: Colors.white, letterSpacing: 0.5),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    'Senior High School - 12th Grade',
                    style: secondaryTextStyle(
                      size: 12,
                      textColor: Colors.white.withOpacity(0.7),
                    ),
                  ),
                )
              ],
            )),
        Expanded(
          child: ListView.builder(
              padding: EdgeInsets.only(bottom: 16),
              itemCount: scoreboardAvailable.length,
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
                          builder: (context) => LDEditStoryView(
                              name: scoreboardAvailable[index].title,
                              backgroundImages: scoreboardAvailable[index]
                                  .backgroundImages),
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
                            'images/loading.png',
                          ),
                          image: Image.asset(
                            scoreboardAvailable[index].image,
                            height: 35,
                            width: 20,
                          ).image,
                        ),
                      ),
                    ),
                    title: Text(
                      scoreboardAvailable[index].title,
                      style: boldTextStyle(size: 16),
                    ),
                    subtitle: Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        scoreboardAvailable[index].subtitle,
                        style: secondaryTextStyle(size: 10),
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
