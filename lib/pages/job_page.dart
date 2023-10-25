import "package:flutter/material.dart";
import "package:url_launcher/url_launcher_string.dart";
import "package:volun/models/user_model.dart";
import "package:volun/pages/other_profile_page.dart";
import "package:volun/utils/logo.dart";
import "package:volun/pages/settings_page.dart";
import "package:volun/utils/globals.dart";
import "package:google_fonts_arabic/fonts.dart";
import "package:volun/components/apply_button.dart";
import "package:volun/models/job_model.dart";
import "package:volun/resources/crud_methods.dart";
import "package:volun/utils/utils.dart";
import "package:volun/resources/auth_methods.dart";
import "package:volun/pages/main_page.dart";
import "package:volun/pages/loading_page.dart";
import 'package:url_launcher/url_launcher.dart';
import 'package:volun/pages/edit_job_page.dart';

Widget jobSectionTitle(String text) {
  return Text(
    text,
    textAlign: TextAlign.start,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
      fontFamily: ArabicFonts.Cairo,
      package: "google_fonts_arabic",
    ),
    textDirection: TextDirection.rtl,
  );
}

Widget jobSectionDetails(String text) {
  return Text(
    text,
    textAlign: TextAlign.justify,
    textDirection: TextDirection.rtl,
    style: const TextStyle(
      fontSize: 20.0,
    ),
  );
}

class JobPage extends StatefulWidget {
  final String jobId;
  const JobPage({Key? key, required this.jobId}) : super(key: key);

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  final CrudMethods _crud = CrudMethods();
  final AuthMethods _auth = AuthMethods();
  Job? _job;
  bool _isApplied = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getJobDetails();
  }

  void getJobDetails() async {
    setState(() {
      isLoading = true;
    });
    Job job = await _crud.getJob(widget.jobId);
    setState(() {
      _job = job;
      for (var user in job.applied) {
        if (user.uid == _auth.getCurrentUserId()) {
          _isApplied = true;
        }
      }
      isLoading = false;
    });
  }

  List<Widget> renderApplied() {
    List<Widget> list = <Widget>[];
    for (User user in _job!.applied) {
      Widget listTile = GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OthersProfilePage(
              user: user,
            ),
          ),
        ),
        child: ListTile(
          subtitle: Text(
            "${user.qualification != '' ? user.qualification : 'بدون مؤهل'} (${user.age} سنة)",
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
          title: Text(
            user.name,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              height: 1.1,
              fontFamily: ArabicFonts.Cairo,
              package: "google_fonts_arabic",
            ),
          ),
          trailing: CircleAvatar(
            backgroundImage: NetworkImage(user.photoUrl),
            radius: 30.0,
          ),
        ),
      );
      list.add(listTile);
      Widget divider = const Divider(
        height: 5.0,
        color: Colors.black,
      );
      list.add(divider);
    }
    return list;
  }

  void applyToJob() async {
    if (_isApplied) return;
    isLoading = true;
    String res = await _crud.applyToJob(jobId: widget.jobId);
    if (res == "success") {
      getJobDetails();
      setState(() {
        _isApplied = true;
        showSnackBar(context, "تم التقديم");
        isLoading = false;
      });
    } else {
      setState(() {
        _isApplied = false;
        showSnackBar(context, res);
      });
    }
  }

  void removeJob() async {
    String res = await _crud.removeJob(jobId: widget.jobId);
    if (res == "success") {
      setState(() {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const MainPage()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_job == null) {
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
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_rounded,
                  size: 30, color: notActiveColor),
            ),
          ),
          body: const LoadingPage(),
        ),
      );
    }
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
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_rounded,
                size: 30, color: notActiveColor),
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                          width: double.infinity,
                          child: Image.network(_job!.photoUrl)),
                      SizedBox(
                          width: double.infinity,
                          child: Text(_job!.jobTitle,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: ArabicFonts.Cairo,
                                  package: "google_fonts_arabic"))),
                      Align(
                        alignment: Alignment.center,
                        child: _isApplied
                            ? Container(
                                width: MediaQuery.of(context).size.width - 80,
                                decoration:
                                    const BoxDecoration(color: Colors.green),
                                child: const Text(
                                  "تم التقـديم",
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      fontFamily: ArabicFonts.Cairo,
                                      package: "google_fonts_arabic"),
                                ),
                              )
                            : ApplyButton(
                                buttonText: "قــدم الآن",
                                width: MediaQuery.of(context).size.width - 50.0,
                                onpressed: () {
                                  applyToJob();
                                },
                              ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  jobSectionDetails(_job!.company.name),
                                  jobSectionTitle("مقدم من: "),
                                ],
                              ),
                              jobSectionTitle("تفاصيل العمل التطوعى"),
                              jobSectionDetails(_job!.details),
                              jobSectionTitle("شروط العمل التطوعى"),
                              jobSectionDetails(_job!.eligibilty),
                              getProfileTileWithCallback("للتواصل واتساب",
                                  Icons.phone, "${_job?.company.phone}", () {
                                if (_job == null) return;
                                String phone = "+2${_job!.company.phone}";
                                String message =
                                    "مرحبا ${_job!.company.name} !";
                                launchUrl(Uri.parse(
                                    "https://api.whatsapp.com/send?phone=$phone&text=$message"));
                              }),
                              jobSectionTitle("المتقـدمين"),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: renderApplied(),
                              ),
                              _job!.company.uid == _auth.getCurrentUserId()
                                  ? ApplyButton(
                                      buttonText: "تعديل المنشــور",
                                      width: MediaQuery.of(context).size.width -
                                          50.0,
                                      onpressed: () {
                                        // removeJob();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditJobPage(job: _job!)));
                                      },
                                      firstColor: Colors.purple.shade900,
                                      secondColor: Colors.purple.shade300)
                                  : Container()
                            ],
                          )),
                    ],
                  ),
                )),
      ),
    );
  }
}
