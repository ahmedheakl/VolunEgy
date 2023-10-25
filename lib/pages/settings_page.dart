import 'package:volun/pages/job_app_page.dart';
import 'package:volun/pages/login_page.dart';
import 'package:volun/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volun/providers/user_provider.dart';
import 'package:volun/resources/auth_methods.dart';
import 'package:google_fonts_arabic/fonts.dart';
import "package:volun/utils/globals.dart";
import "package:volun/pages/user_posts_page.dart";
import "package:volun/pages/user_applied_page.dart";
import "package:volun/pages/profile_page.dart";
import "package:volun/pages/intro_page.dart";
import "package:volun/pages/edit_user_page.dart";

Widget renderCardTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 5, left: 10),
    child: Text(
      title,
      textAlign: TextAlign.right,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 106, 111, 141),
      ),
    ),
  );
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  _promptUserLogoutDialoug(BuildContext parentContext) {
    return showDialog(
        context: parentContext,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text("هل انت متاكد؟",
                style: TextStyle(fontWeight: FontWeight.bold)),
            children: <Widget>[
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("تسجيل الخروج"),
                onPressed: () {
                  AuthMethods().signOut();
                  showSnackBar(
                    context,
                    "تم تسجيل الخروج.",
                    textDirection: TextDirection.rtl,
                  );
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginPage()));
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("الغـاء"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  VoidCallback jumpToApplicationPage(BuildContext context) {
    return () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const JobApp()));
    };
  }

  VoidCallback jumpToMyPostsPage(BuildContext context) {
    return () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const UserPostsPage()));
    };
  }

  VoidCallback jumpToMyApplicationsPage(BuildContext context) {
    return () {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const UserAppliedPage()));
    };
  }

  VoidCallback jumpToProfilePage(BuildContext context) {
    return () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const ProfilePage()));
    };
  }

  VoidCallback jumpToIntroPage(BuildContext context) {
    return () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const IntroPage()));
    };
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: const Text("الإعــدادت",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: ArabicFonts.Cairo,
                    package: "google_fonts_arabic",
                  )),
              backgroundColor: backgroundColor,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_rounded,
                    size: 30, color: notActiveColor),
              ),
              actions: const [
                Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(Icons.search_rounded,
                        size: 30, color: notActiveColor)),
              ],
            ),
            body: Container(
                decoration: const BoxDecoration(color: backgroundColor),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Card(
                          child: Consumer<UserProvider>(
                            builder: (context, userProv, child) =>
                                GestureDetector(
                              child: ListTile(
                                title: Text(userProv.getUser.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),
                                subtitle: Text(userProv.getUser.email,
                                    style: const TextStyle(fontSize: 15)),
                                dense: true,
                                leading: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: NetworkImage(
                                        userProv.getUser.photoUrl)),
                                trailing: Container(
                                  decoration: const BoxDecoration(
                                      color:
                                          Color.fromARGB(255, 210, 255, 195)),
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.check_circle_outline,
                                          size: 20,
                                          color:
                                              Color.fromARGB(255, 78, 168, 73)),
                                      Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text("Verified",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color.fromARGB(
                                                      255, 19, 24, 60))))
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const EditUserPage()));
                              },
                            ),
                          ),
                        ),
                        renderCardTitle("الخصوصيـة"),
                        Card(
                          child: getSettingTile(
                            "الشخصـية",
                            Icons.account_circle_outlined,
                            jumpToProfilePage(context),
                          ),
                        ),
                        renderCardTitle("التطـوع"),
                        Card(
                            child: Column(children: [
                          getSettingTile(
                            "مشاركاتى التطوعية",
                            Icons.task_outlined,
                            jumpToMyApplicationsPage(context),
                          ),
                          const Divider(
                            color: Color.fromARGB(255, 217, 219, 229),
                            height: 2,
                            thickness: 2,
                          ),
                          getSettingTile(
                            "أنشطتى التطوعية",
                            Icons.collections_outlined,
                            jumpToMyPostsPage(context),
                          ),
                          const Divider(
                            color: Color.fromARGB(255, 217, 219, 229),
                            height: 2,
                            thickness: 2,
                          ),
                          getSettingTile(
                            "إنشاء عمل تطوعى",
                            Icons.post_add_outlined,
                            jumpToApplicationPage(context),
                          )
                        ])),
                        renderCardTitle("المــزيد"),
                        Card(
                          child: getSettingTile(
                            "المسـاعدة",
                            Icons.contact_support_outlined,
                            jumpToIntroPage(context),
                          ),
                        ),
                      ],
                    ),
                  )
                ])),
            bottomNavigationBar: BottomAppBar(
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        side: const BorderSide(
                            color: Color.fromARGB(255, 63, 103, 248), width: 2),
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () => _promptUserLogoutDialoug(context),
                      child: const Text("تسجيـل الخروج",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 63, 103, 248),
                              fontFamily: ArabicFonts.Cairo,
                              package: "google_fonts_arabic")),
                    )))));
  }
}
