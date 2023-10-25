import 'package:volun/pages/edit_user_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volun/providers/user_provider.dart';
import 'package:google_fonts_arabic/fonts.dart';
import "package:volun/utils/globals.dart";
import 'package:volun/models/user_model.dart';
import 'package:volun/utils/utils.dart';

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

class OthersProfilePage extends StatelessWidget {
  final User user;
  const OthersProfilePage({super.key, required this.user});

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
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Card(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(user.photoUrl),
                            backgroundColor: Colors.red,
                          ),
                          Text(
                            user.name,
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
                                user.email,
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
                    renderCardTitle("البيانــات"),
                    Card(
                      child: Column(
                        children: [
                          getProfileTile(
                            "العنــوان",
                            Icons.contact_mail_outlined,
                            user.address,
                          ),
                          const Divider(
                            color: Color.fromARGB(255, 217, 219, 229),
                            height: 2,
                            thickness: 2,
                          ),
                          getProfileTile(
                            "رقـم التلفون",
                            Icons.call_outlined,
                            user.phone,
                          ),
                          const Divider(
                            color: Color.fromARGB(255, 217, 219, 229),
                            height: 2,
                            thickness: 2,
                          ),
                          getProfileTile(
                            "العمر",
                            Icons.people_outlined,
                            user.age,
                          ),
                          const Divider(
                            color: Color.fromARGB(255, 217, 219, 229),
                            height: 2,
                            thickness: 2,
                          ),
                          getProfileTile(
                            "المــؤهل",
                            Icons.engineering_outlined,
                            user.qualification,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
