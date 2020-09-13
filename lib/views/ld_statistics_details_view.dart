import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:drops/entities/ScoreboardAvailableModel.dart';
import 'package:drops/utils/ld_colors.dart';
import 'package:drops/utils/ld_style.dart';

class LDStatisticsDetailsView extends StatefulWidget {
  @override
  _LDStatisticsDetailsViewState createState() => _LDStatisticsDetailsViewState();
}

class _LDStatisticsDetailsViewState extends State<LDStatisticsDetailsView> {
  List<ScoreboardModel> mScoreList = [
    ScoreboardModel(
      title: 'Math Exam 2',
      subtitle: 'Passed',
      status: 70,
    ),
    ScoreboardModel(
      title: 'English-Week 2',
      subtitle: 'Passed',
      status: 80,
    ),
    ScoreboardModel(
      title: 'Physics Final Exam',
      subtitle: 'Passed',
      status: 30,
    ),
    ScoreboardModel(
      title: 'Math Exam 2',
      subtitle: 'Passed',
      status: 70,
    ),
    ScoreboardModel(
      title: 'English-Week 2',
      subtitle: 'Passed',
      status: 90,
    ),
    ScoreboardModel(
      title: 'Physics Final Exam',
      subtitle: 'Passed',
      status: 30,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Widget mOption(var mHeading, var mSubHeading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            mHeading,
            style: primaryTextStyle(size: 16, textColor: ldTextPrimaryColor),
          ),
          SizedBox(height: 4,),
          Text(
            mSubHeading,
            style: primaryTextStyle(size: 14, textColor: ldTextSecondaryColor),
          )
        ],
      );
    }

    Widget mLeaderList(ScoreboardModel mScoreboardModel) {
      return Container(
        decoration: boxDecorations(showShadow: true),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only( top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mScoreboardModel.title,
                  style: boldTextStyle(size: 16),
                ),
                Text(
                  mScoreboardModel.subtitle,
                  style: secondaryTextStyle(size: 10),
                ),
              ],
            ),
            CircleAvatar(
              radius: 15,
              backgroundColor: (mScoreboardModel.status > 70)
                  ? ldSecondaryColorGreen.withOpacity(0.7)
                  : ldSecondaryColorYellow.withOpacity(0.7),
              child: Text(
                mScoreboardModel.status.toInt().toString(),
                style: boldTextStyle(textColor: Colors.white, size: 16),
              ),
            )
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(
                Icons.favorite_border,
                color: Colors.white,
              ),
            ),
          ],
          backgroundColor: ldPrimaryColor,
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: width * 0.3,
                color: ldPrimaryColor,
              ),
              Container(
                margin: EdgeInsets.only(left: 16,right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: boxDecorations(bgColor: Colors.deepOrangeAccent.withOpacity(0.8)),
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "71",
                            style:
                                primaryTextStyle(size: 18, textColor: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Good",
                              style: primaryTextStyle(
                                  size: 16, textColor: Colors.white),
                            ),
                            Text(
                              "Your progress",
                              style: primaryTextStyle(
                                  size: 16, textColor: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: boxDecoration(
                        radius: 8,
                        backGroundColor: Colors.white,
                        spreadRadius: 2,
                        blurRadius: 10,
                      ),
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          mOption("Exam", "75"),
                          Container(height: 22,color: ldViewColor,width: 1,),
                          mOption("Lessons", "80"),
                          Container(height: 22,color: ldViewColor,width: 1,),
                          mOption("Pass", "75"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "List of exams",
                      style: secondaryTextStyle(
                          size: 14, textColor: ldTextSecondaryColor),
                    ),
                    ListView.builder(
                        itemCount: mScoreList.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 16),
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return mLeaderList(mScoreList[index]);
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
