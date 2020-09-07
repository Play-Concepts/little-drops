import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drops/services/LDColors.dart';
import 'package:drops/services/LDStyle.dart';
import 'package:drops/views/LDHomePageView.dart';

class LDLoginView extends StatefulWidget {
  @override
  _LDLoginViewState createState() => _LDLoginViewState();
}

class _LDLoginViewState extends State<LDLoginView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    changeStatusColor(ldAppBackground);
    return SafeArea(
      child: Scaffold(
        backgroundColor: ldAppBackground,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Welcome!',
                    style: boldTextStyle(size: 25),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: size.width,
                    decoration: boxDecorations(
                      showShadow: true,
                    ),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          cursorColor: ldTextSecondaryColor.withOpacity(0.2),
                          cursorWidth: 1,
                          autocorrect: true,
                          autofocus: false,
                          decoration: InputDecoration(
                            hintText: 'Email Address',
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
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SDButton(
                    textContent: "SIGN IN",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LDHomePageView(),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                    'This application requires you to have a HAT Personal Data Account.\n\nEnter your email address. You will be redirected to your HAT PDA for authentication. Otherwise a HAT PDA will automatically be created for you.',
                    style: secondaryTextStyle(size: 16),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
