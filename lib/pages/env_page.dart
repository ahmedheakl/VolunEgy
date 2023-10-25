import 'package:flutter/material.dart';
import "package:volun/models/job_model.dart";
import "package:volun/resources/crud_methods.dart";
import "package:volun/utils/globals.dart";
import "package:volun/utils/utils.dart";

class EnvPage extends StatefulWidget {
  const EnvPage({Key? key}) : super(key: key);

  @override
  State<EnvPage> createState() => _EnvPageState();
}

class _EnvPageState extends State<EnvPage> {
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
      if (job.jobType == "env") {
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
          )),
    ));
  }
}
