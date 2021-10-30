import 'package:drops/utils/ld_colors.dart';
import 'package:drops/utils/ld_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class LDFirstChildView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    changeStatusColor(ldAppBackground);
    return SafeArea(
      child: Scaffold(
        backgroundColor: ldAppBackground,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 284,
                  child: Text(
                    "Register A Child",
                    textAlign: TextAlign.center,
                    style: titleStyle(),
                  ),
                ),
                SizedBox(height: 128),
                Image.asset(
                  'images/welcome/select_child_main.png',
                  height: 200,
                  width: 225,
                ),
                SizedBox(height: 128),
                GestureDetector(
                  onTap: () => {},
                  child: Container(
                    width: 312,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Color(0xffbf62a2),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Register Child",
                              style: GoogleFonts.baloo(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
