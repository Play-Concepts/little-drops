import 'package:flutter/material.dart';
import 'package:drops/utils/ld_colors.dart';
import 'package:drops/utils/ld_style.dart';

class LDProfileSettingsView extends StatefulWidget {
  @override
  _LDProfileSettingsViewState createState() => _LDProfileSettingsViewState();
}

class _LDProfileSettingsViewState extends State<LDProfileSettingsView> {
  @override
  Widget build(BuildContext context) {
    Widget mOption(var icon, var heading) {
      return Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  icon,
                  color: ldIconColor,
                  size: 18,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  heading,
                  style:
                      primaryTextStyle(size: 16, textColor: ldTextPrimaryColor),
                ),
              ],
            ),
            Icon(
              Icons.keyboard_arrow_right,
              color: ldIconColor,
            )
          ],
        ),
      );
    }

    Widget mDivider() {
      return Container(
        color: ldViewColor,
//        margin: EdgeInsets.only(bottom: 10),
        height: 1,
      );
    }

    changeStatusColor(ldAppBackground);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text('Settings', style: boldTextStyle(size: 20)),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: <Widget>[
            mOption(Icons.launch, "Logout"),
          ],
        ),
      ),
    );
  }
}
