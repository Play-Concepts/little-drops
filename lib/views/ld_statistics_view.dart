import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drops/entities/child.dart';
import 'package:drops/utils/ld_colors.dart';
import 'package:drops/utils/ld_style.dart';

import 'ld_statistics_details_view.dart';

List<Child> students = [
  Child(
      data: ChildData(
    image:
        'https://cdn.fastly.picmonkey.com/contentful/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24E953B920A9CD0FF2E1D587742A2472/1-intro-photo-final.jpg?w=800&q=70',
    name: 'Karnia Oktavia',
    message: 'Excellent work',
    score: 100,
  )),
  Child(
      data: ChildData(
    image:
        'https://i.insider.com/5de6dd81fd9db241b00c04d3?width=1100&format=jpeg&auto=webp',
    name: 'Kamaludin Abdul',
    message: 'Good work',
    score: 97,
  ))
];

Widget LDStatisticsView([BuildContext context, Size size]) {
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
                'Statistics',
                style: boldTextStyle(
                    size: 18, textColor: Colors.white, letterSpacing: 0.5),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  'How are your children doing?',
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
          scrollDirection: Axis.vertical,
          itemCount: students == null ? 0 : students.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LDStatisticsDetailsView(),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                padding:
                    EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
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
                            students[index].data.image,
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
                          Text(
                            students[index].data.name,
                            style: boldTextStyle(size: 16),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              students[index].data.message,
                              style: secondaryTextStyle(size: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      students[index].data.score.toString(),
                      style: boldTextStyle(),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}
