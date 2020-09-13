import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drops/utils/ld_colors.dart';
import 'package:drops/utils/ld_style.dart';
import 'package:drops/views/ld_login_view.dart';

class LDWalkThroughView extends StatefulWidget {
  @override
  _LDWalkThroughViewState createState() => _LDWalkThroughViewState();
}

class _LDWalkThroughViewState extends State<LDWalkThroughView> {
  bool isActive;
  PageController pageController = PageController(initialPage: 0);
  int pageChanged = 0;

  List<Widget> buildDotIndicator() {
    List<Widget> list = [];
    for (int i = 0; i <= 2; i++) {
      list.add(i == pageChanged
          ? sDDotIndicator(isActive: true)
          : sDDotIndicator(isActive: false));
    }

    return list;
  }

  Widget sDDotIndicator({bool isActive}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: isActive ? 8.0 : 6.0,
      width: isActive ? 8.0 : 6.0,
      decoration: BoxDecoration(
        color: isActive ? ldPrimaryColor : Color(0xFF7E869B),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: size.height * 0.7,
              child: PageView(
                onPageChanged: (index) {
                  setState(() {
                    pageChanged = index;
                  });
                },
                controller: pageController,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.1, left: 10, right: 10),
                        child: Image(
                          image:
                              AssetImage('images/sduser.png'),
                          height: size.height * 0.3,
                          width: size.width,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 4),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Text('Personalise',
                              textAlign: TextAlign.center,
                              style: boldTextStyle(size: 25)),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 40),
                        child: Text(
                            'Write interesting stories for your children.',
                            textAlign: TextAlign.justify,
                            style: secondaryTextStyle(size: 16)),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.1, left: 10, right: 10),
                        child: Image(
                          image: AssetImage(
                              'images/sdreport.png'),
                          height: size.height * 0.3,
                          width: size.width,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 4),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Text('Progress Reports\n(UPCOMING FEATURE)',
                              textAlign: TextAlign.center,
                              style: boldTextStyle(size: 25)),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 40),
                        child: Text(
                            'Track the reading progress of your children.',
                            textAlign: TextAlign.justify,
                            style: secondaryTextStyle(size: 16)),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.1, left: 10, right: 10),
                        child: Image(
                          image:
                              AssetImage('images/sdclip.png'),
                          height: size.height * 0.3,
                          width: size.width,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 4),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Text('Protect your Privacy',
                              textAlign: TextAlign.center,
                              style: boldTextStyle(size: 25)),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 40),
                        child: Text(
                            'Little Drops is built with HAT Platform Technology. All your data is stored on your own Personal Data Account.',
                            textAlign: TextAlign.justify,
                            style: secondaryTextStyle(size: 16)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: buildDotIndicator(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  pageChanged != 2
                      ? InkWell(
                          child: CircleAvatar(
                            radius: 25,
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                            backgroundColor: ldPrimaryColor,
                          ),
                          onTap: () {
                            pageController.nextPage(
                                duration: Duration(milliseconds: 250),
                                curve: Curves.easeInOut);
                          },
                        )
                      : Container(
                          margin:
                              EdgeInsets.only(bottom: 0, left: 20, right: 20),
                          width: size.width,
                          height: 50,
                          child: RaisedButton(
                            color: ldPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 1,
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LDLoginView(),
                                ),
                              );
                            },
                            child: Text(
                              "GET STARTED",
                              textAlign: TextAlign.center,
                              style: boldTextStyle(
                                  size: 16,
                                  textColor: Colors.white,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
