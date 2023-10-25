import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import "package:volun/pages/job_page.dart";
import 'package:google_fonts_arabic/fonts.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
}

showSnackBar(BuildContext context, String text,
    {TextDirection textDirection = TextDirection.ltr}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
      textDirection: textDirection,
    ),
  ));
}

Widget getVolunteerCard(
  BuildContext context,
  String imagePath,
  String companyName,
  String companyPhotoPath,
  String jobSpeciality,
  String jobId,
) {
  return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: Color.fromARGB(88, 230, 141, 134))),
      child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => JobPage(jobId: jobId)));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Text(
                        companyName,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: ArabicFonts.Changa, // Baloo_Bhaijaan
                            package: "google_fonts_arabic"),
                      ),
                      Text(
                        jobSpeciality,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textDirection: TextDirection.rtl,
                      )
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                        bottom: 0,
                        right: 10,
                        left: 10,
                      ),
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(companyPhotoPath),
                          radius: 20)),
                ],
              ),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(imagePath),
                    ),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
              ),
            ],
          )));
}

Widget getSettingTile(String title, IconData icon, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: ListTile(
      leading: const Icon(
        Icons.chevron_left_outlined,
        size: 20,
        color: Color.fromARGB(255, 106, 111, 141),
      ),
      title: Text(
        title,
        textAlign: TextAlign.right,
        style: const TextStyle(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      trailing: Icon(
        icon,
        size: 30,
        color: const Color.fromARGB(255, 106, 111, 141),
      ),
    ),
  );
}

Widget getProfileTile(
  String title,
  IconData icon,
  String subtitle,
) {
  return ListTile(
    subtitle: Text(
      subtitle,
      textAlign: TextAlign.right,
    ),
    title: Text(
      title,
      textAlign: TextAlign.right,
      style: const TextStyle(
          fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
    ),
    trailing: Icon(
      icon,
      size: 30,
      color: const Color.fromARGB(255, 106, 111, 141),
    ),
  );
}

Widget getProfileTileWithCallback(
  String title,
  IconData icon,
  String subtitle,
  VoidCallback onTap,
) {
  return Container(
    color: const Color.fromARGB(255, 250, 206, 140),
    child: GestureDetector(
        onTap: onTap,
        child: ListTile(
          leading: const Icon(
            Icons.chevron_left_outlined,
            size: 20,
            color: Color.fromARGB(255, 106, 111, 141),
          ),
          subtitle: Text(
            subtitle,
            textAlign: TextAlign.right,
          ),
          title: Text(
            title,
            textAlign: TextAlign.right,
            style: const TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(
            icon,
            size: 30,
            color: const Color.fromARGB(255, 106, 111, 141),
          ),
        )),
  );
}
