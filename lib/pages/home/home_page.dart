import 'package:auto_point_mobile/pages/account/account_page.dart';
import 'package:auto_point_mobile/pages/wish_list/wish_list.dart';
import 'package:auto_point_mobile/pages/order/order_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../utils/colors.dart';
import 'main_page.dart';

class HomePage extends StatefulWidget {
  final directory;
  const HomePage({Key? key, required this.directory}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState(directory: directory);
}

class _HomePageState extends State<HomePage> {
  late BuildContext testContext;

  final directory;

  _HomePageState({required this.directory});

  late PersistentTabController _controller;
  late bool _hideNavBar;
  late List pages;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();

    _controller = PersistentTabController(initialIndex: 0);
    _selectedIndex = 0;
    _hideNavBar = false;
  }

  void onTapNav(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _buildScreens() => [
    MainPage(directory: directory),
    OrderPage(directory: directory),
    WishList(directory: directory,),
    AccountPage(directory: directory,),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home),
      title: "Home",
      activeColorPrimary: AppColors.mainColor,
      inactiveColorPrimary: AppColors.secondaryColor,
    ),

    PersistentBottomNavBarItem(
      icon: const Icon(Icons.history),
      title: "My orders",
      activeColorPrimary: AppColors.mainColor,
      inactiveColorPrimary: AppColors.secondaryColor,
    ),

    PersistentBottomNavBarItem(
      icon: const Icon(Icons.favorite_outlined),
      title: "Wish list",
      activeColorPrimary: AppColors.mainColor,
      inactiveColorPrimary: AppColors.secondaryColor,
    ),

    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person),
      title: "Account",
      activeColorPrimary: AppColors.mainColor,
      inactiveColorPrimary: AppColors.secondaryColor,
    ),
  ];

  @override
  Widget build(final BuildContext context) => WillPopScope(
    onWillPop: ()async {
      // Return true to allow the back button
      return false;
    },
    child: Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        resizeToAvoidBottomInset: true,
        navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
            ? 0.0
            : kBottomNavigationBarHeight,
        bottomScreenMargin: 0,
        onWillPop: (final context) async {
          await showDialog(
            context: context!,
            useSafeArea: true,
            builder: (final context) => Container(
              height: 50,
              width: 50,
              color: Colors.white,
              child: ElevatedButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
          return false;
        },
        selectedTabScreenContext: (final context) {
          testContext = context!;
        },
        backgroundColor: Colors.white,
        hideNavigationBar: _hideNavBar,
        decoration: const NavBarDecoration(colorBehindNavBar: Colors.orange),
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
        ),
        navBarStyle: NavBarStyle
            .style9, // Choose the nav bar style with this property
      ),
    ),
  );
}
