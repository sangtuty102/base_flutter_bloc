import 'dart:io';

import 'package:base_flutter_bloc/const/all_const.dart';
import 'package:base_flutter_bloc/feature/home/profile/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'notifycation/notify_page.dart';

DateTime
    _currentBackPressTime; // biến để xác đinh thời gian lúc nhân Back() để thoát app

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePage> {
  PageController _pageController =
      PageController(initialPage: 0); // controller để xác định pageView
  int _bottomSelectedIndex = 0; // vị trí hiện tại của item của bottomBar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: _buildPageView(),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildPageView() {
    return PageView(
      scrollDirection: Axis.horizontal,
      physics:
          NeverScrollableScrollPhysics(), // cho vuốt qua lại giữa các page ko
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          // _tabController.index = index;
          _bottomSelectedIndex = index;
        });
      },
      children: <Widget>[
        NotifyPage(),
        ProfilePage(),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
        unselectedItemColor: Colors.white,
        currentIndex: _bottomSelectedIndex,
        backgroundColor: AppColors.darkAccentColor,
        selectedItemColor: Colors.blue,
        onTap: (index) => _bottomTapped(index),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: _buildBottomNavBarItems());
  }

  List<BottomNavigationBarItem> _buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
        icon: _buildItem(Icons.home),
        label: AppStr.home,
      ),
      BottomNavigationBarItem(
        icon: _buildItem(Icons.person),
        label: AppStr.person,
      ),
    ];
  }

  Widget _buildItem(IconData icon) {
    return Icon(
      icon,
      size: AppDimens.sizeIconLarge,
    );
  }

  void _bottomTapped(int index) {
    setState(() {
      _bottomSelectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }
}

Future<bool> onWillPop() {
  DateTime now = DateTime.now();
  if (_currentBackPressTime == null ||
      now.difference(_currentBackPressTime) > Duration(seconds: 2)) {
    _currentBackPressTime = now;
    Fluttertoast.showToast(msg: AppStr.exitApp);
    return Future.value(false);
  } else {
    exit(0); // tương ứng với thoát app
  }
}
