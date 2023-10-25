import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:volun/utils/logo.dart";
import "package:volun/utils/globals.dart";
import 'package:volun/models/user_model.dart' as model;
import "package:volun/providers/user_provider.dart";
import 'package:provider/provider.dart';
import "package:volun/pages/settings_page.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

Widget getBarItem(String title, IconData icon, Color color) {
  Color backgroundColor = color == Colors.white ? redColor : Colors.white;
  return Container(
      height: double.infinity,
      decoration: BoxDecoration(color: backgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textDirection: TextDirection.rtl,
          ),
          Container(
              padding: const EdgeInsets.only(left: 5.0),
              child: Icon(icon, color: color, size: 20.0))
        ],
      ));
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _page = 0;
  late PageController pageController;
  model.User? user;

  @override
  void initState() {
    super.initState();
    getData();
    pageController = PageController();
  }

  getData() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await userProvider.refreshUser();
    setState(() {
      user = userProvider.getUser;
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChange(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTap(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: getLogo(30.0),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            GestureDetector(
              child: Container(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: const Icon(
                    Icons.settings_rounded,
                    color: Colors.black,
                    size: 30.0,
                  )),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsPage()));
              },
            ),
          ],
          leading: user != null
              ? Consumer<UserProvider>(builder: (context, userProv, child) {
                  return Padding(
                      padding: const EdgeInsets.only(left: 5, top: 5),
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(userProv.getUser.photoUrl),
                        radius: 20,
                      ));
                })
              : const Icon(Icons.person_off_outlined,
                  size: 20, color: secondaryColor),
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChange,
          children: homePageItems,
        ),
        bottomNavigationBar: CupertinoTabBar(
            onTap: navigationTap,
            currentIndex: _page,
            backgroundColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: getBarItem("بيئـة", Icons.compost_outlined,
                    _page == 0 ? Colors.white : redColor),
              ),
              BottomNavigationBarItem(
                icon: getBarItem("مجتمع", Icons.people_outline,
                    _page == 1 ? Colors.white : redColor),
              ),
              BottomNavigationBarItem(
                icon: getBarItem("بريـة", Icons.forest_outlined,
                    _page == 2 ? Colors.white : redColor),
              ),
              BottomNavigationBarItem(
                icon: getBarItem("ذوى الهمم", Icons.accessibility,
                    _page == 3 ? Colors.white : redColor),
              )
            ]),
      ),
    );
  }
}
