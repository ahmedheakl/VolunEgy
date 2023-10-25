import "package:flutter/material.dart";
import "package:volun/utils/logo.dart";
import "package:volun/utils/globals.dart";
import "package:google_fonts_arabic/fonts.dart";
import "package:volun/components/apply_button.dart";
import "package:volun/pages/login_page.dart";

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  Widget renderPeople() {
    List<Widget> children = <Widget>[];
    for (String person in listPeople) {
      children.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              person,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Icon(
              Icons.people_outlined,
              color: Color.fromARGB(255, 106, 111, 141),
              size: 30.0,
            )
          ],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: getLogo(30.0),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.0, child: Container()),
              SizedBox(
                width: double.infinity,
                child: Image.asset("assests/images/intro_pic.jpg"),
              ),
              const Text(
                "من نحـن؟",
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  fontFamily: ArabicFonts.Cairo,
                  package: "google_fonts_arabic",
                ),
              ),
              Text(
                introText,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 20.0,
                  height: 1.1,
                ),
              ),
              const Divider(
                color: Color.fromARGB(255, 217, 219, 229),
                height: 2,
                thickness: 2,
              ),
              const Text(
                "إهــداء إلى",
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  fontFamily: ArabicFonts.Cairo,
                  package: "google_fonts_arabic",
                ),
              ),
              const Divider(
                color: Colors.white,
                height: 2,
                thickness: 2,
              ),
              renderPeople(),
              const Divider(
                color: Color.fromARGB(255, 217, 219, 229),
                height: 2,
                thickness: 2,
              ),
              const Text(
                "إعــداد",
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  fontFamily: ArabicFonts.Cairo,
                  package: "google_fonts_arabic",
                ),
              ),
              const ListTile(
                subtitle: Text(
                  "مدرسة عبدالواحد البسومى ث",
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                title: Text(
                  "سهيلة محمد هيكل",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                    fontFamily: ArabicFonts.Cairo,
                    package: "google_fonts_arabic",
                  ),
                ),
                trailing: CircleAvatar(
                  backgroundImage: AssetImage("assests/images/my_photo.jpeg"),
                  radius: 30.0,
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: ApplyButton(
          buttonText: "التــالى",
          width: MediaQuery.of(context).size.width - 50.0,
          onpressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
        ),
      ),
    ));
  }
}
