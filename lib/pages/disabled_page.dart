import 'package:flutter/material.dart';
import "package:volun/models/job_model.dart";
import "package:volun/resources/crud_methods.dart";
import "package:volun/utils/globals.dart";
import "package:volun/utils/utils.dart";

class DisabledPage extends StatefulWidget {
  const DisabledPage({Key? key}) : super(key: key);

  @override
  State<DisabledPage> createState() => _DisabledPageState();
}

class _DisabledPageState extends State<DisabledPage> {
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
      if (job.jobType == "disabled") {
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
