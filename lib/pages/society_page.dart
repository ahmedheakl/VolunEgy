import 'package:flutter/material.dart';
import "package:volun/models/job_model.dart";
import "package:volun/resources/crud_methods.dart";
import "package:volun/utils/globals.dart";
import "package:volun/utils/utils.dart";

class SocietyPage extends StatefulWidget {
  const SocietyPage({Key? key}) : super(key: key);

  @override
  State<SocietyPage> createState() => _SocietyPageState();
}

class _SocietyPageState extends State<SocietyPage> {
  List<Job>? _jobs;
  final CrudMethods _crud = CrudMethods();

  @override
  void initState() {
    super.initState();
    getJobs();
  }

  void getJobs() async {
    List<Job> jobs = await _crud.getAllJobs();
    setState(() {
      _jobs = jobs;
    });
  }

  List<Widget> renderJobs() {
    List<Widget> list = <Widget>[];
    if (_jobs == null) return list;
    for (var job in _jobs!) {
      if (job.jobType == "society") {
        list.add(getVolunteerCard(
          context,
          job.photoUrl,
          job.company.name,
          job.company.photoUrl,
          job.jobTitle,
          job.uid,
        ));
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: backgroundColor),
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListView(
                        children: renderJobs(),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}


// getVolunteerCard(
//                               context,
//                               "assests/images/food_volunteer.jpg",
//                               "رسـالة",
//                               "assests/images/resala.png",
//                               "توزيـع طعام"),
//                           getVolunteerCard(
//                               context,
//                               "assests/images/env_photo_1.jpg",
//                               "مصر الخيــر",
//                               "assests/images/misr_elkheir.jpeg",
//                               "زراعة أشجـار"),
//                           getVolunteerCard(
//                               context,
//                               "assests/images/env_photo_2.jpeg",
//                               "الأورمـان",
//                               "assests/images/orman.jpg",
//                               "تنظيف شواطئ")