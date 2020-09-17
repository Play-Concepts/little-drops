import 'package:cached_network_image/cached_network_image.dart';
import 'package:drops/controllers/stories_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drops/utils/ld_colors.dart';
import 'package:drops/utils/ld_style.dart';
import 'package:drops/views/ld_stories_view.dart';
import 'package:drops/views/ld_edit_stories_view.dart';
import 'package:drops/views/ld_statistics_view.dart';
import 'package:drops/views/ld_profile_view.dart';
import 'package:get/get.dart';

class LDHomePageView extends StatelessWidget {
  RxInt _currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    changeStatusColor(ldAppBackground);
    final tab = [
      LDStoriesView(context),
      LDEditStoriesView(),
      LDStatisticsView(context, size),
      LDProfileView(),
    ];

    return SafeArea(
      child: Obx(() => Scaffold(
          backgroundColor: ldAppBackground,
          body: tab[_currentIndex.value],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(color: ldShadowColor, spreadRadius: 0, blurRadius: 2)
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: false,
                showSelectedLabels: false,
                currentIndex: _currentIndex.value,
                items: [
                  BottomNavigationBarItem(
                    icon:
                        Icon(Icons.library_books, size: 28, color: ldIconColor),
                    activeIcon: Icon(Icons.library_books,
                        size: 28, color: ldPrimaryColor),
                    title: Text('a'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.edit, size: 28, color: ldIconColor),
                    activeIcon:
                        Icon(Icons.edit, size: 28, color: ldPrimaryColor),
                    title: Text('a'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.pie_chart, size: 28, color: ldIconColor),
                    activeIcon:
                        Icon(Icons.pie_chart, size: 28, color: ldPrimaryColor),
                    title: Text('a'),
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      height: 30,
                      width: 30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: CachedNetworkImage(
                            imageUrl:
                                'https://i.insider.com/5de6dd81fd9db241b00c04d3?width=1100&format=jpeg&auto=webp',
                            fit: BoxFit.cover,
                            height: 35,
                            width: 10),
                      ),
                    ),
                    activeIcon: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: ldPrimaryColor, width: 2)),
                      height: 30,
                      width: 30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              'https://i.insider.com/5de6dd81fd9db241b00c04d3?width=1100&format=jpeg&auto=webp',
                          height: 35,
                          width: 10,
                        ),
                      ),
                    ),
                    title: Text('a'),
                  ),
                ],
                onTap: (index) => _currentIndex.value = index,
              ),
            ),
          ))),
    );
  }
}
