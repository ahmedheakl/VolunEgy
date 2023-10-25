import 'package:volun/pages/edit_user_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volun/providers/user_provider.dart';
import 'package:google_fonts_arabic/fonts.dart';
import "package:volun/utils/globals.dart";
import "package:volun/utils/utils.dart";

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

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // _promptUserLogoutDialoug(BuildContext parentContext) {
  //   return showDialog(
  //       context: parentContext,
  //       builder: (BuildContext context) {
  //         return SimpleDialog(
  //           title: const Text("هل انت متاكد؟",
  //               style: TextStyle(fontWeight: FontWeight.bold)),
  //           children: <Widget>[
  //             SimpleDialogOption(
  //               padding: const EdgeInsets.all(20),
  //               child: const Text("تسجيل الخروج"),
  //               onPressed: () {
  //                 AuthMethods().signOut();
  //                 showSnackBar(
  //                   context,
  //                   "تم تسجيل الخروج.",
  //                   textDirection: TextDirection.rtl,
  //                 );
  //                 Navigator.of(context).pushReplacement(MaterialPageRoute(
  //                     builder: (context) => const LoginPage()));
  //               },
  //             ),
  //             SimpleDialogOption(
  //               padding: const EdgeInsets.all(20),
  //               child: const Text("الغـاء"),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //             )
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text("الشخصيــة",
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
                        builder: (context, userProv, child) => Column(
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundImage:
                                  NetworkImage(userProv.getUser.photoUrl),
                              backgroundColor: Colors.red,
                            ),
                            Text(
                              userProv.getUser.name,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                                fontFamily: ArabicFonts.Cairo,
                                package: "google_fonts_arabic",
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 10.0,
                                ),
                                child: Text(
                                  userProv.getUser.email,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    renderCardTitle("البيانــات"),
                    Card(
                        child: Consumer<UserProvider>(
                      builder: (context, userProv, child) => Column(
                        children: [
                          getProfileTile(
                            "العنــوان",
                            Icons.contact_mail_outlined,
                            userProv.getUser.address,
                          ),
                          const Divider(
                            color: Color.fromARGB(255, 217, 219, 229),
                            height: 2,
                            thickness: 2,
                          ),
                          getProfileTile(
                            "رقـم التلفون",
                            Icons.call_outlined,
                            userProv.getUser.phone,
                          ),
                          const Divider(
                            color: Color.fromARGB(255, 217, 219, 229),
                            height: 2,
                            thickness: 2,
                          ),
                          getProfileTile(
                            "العمر",
                            Icons.people_outlined,
                            userProv.getUser.age,
                          ),
                          const Divider(
                            color: Color.fromARGB(255, 217, 219, 229),
                            height: 2,
                            thickness: 2,
                          ),
                          getProfileTile(
                            "المــؤهل",
                            Icons.engineering_outlined,
                            userProv.getUser.qualification,
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              )
            ])),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                side: const BorderSide(
                    color: Color.fromARGB(255, 63, 103, 248), width: 2),
                backgroundColor: Colors.white,
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditUserPage(),
                ),
              ),
              child: const Text(
                "تعديــل البيانات",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 63, 103, 248),
                  fontFamily: ArabicFonts.Cairo,
                  package: "google_fonts_arabic",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
