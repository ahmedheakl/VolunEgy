import "package:flutter/material.dart";
import "package:volun/utils/logo.dart";
import "package:volun/components/text_field_input.dart";
import "package:volun/utils/utils.dart";
import "package:image_picker/image_picker.dart";
import "package:volun/components/large_text_input.dart";
import "package:volun/resources/crud_methods.dart";
import "package:volun/pages/main_page.dart";
import 'package:flutter/services.dart';
import "package:volun/utils/globals.dart";

class JobApp extends StatefulWidget {
  const JobApp({super.key});

  @override
  State<JobApp> createState() => _JobAppState();
}

class _JobAppState extends State<JobApp> {
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _eligibiltyController = TextEditingController();
  final String defaultPicPath = "assests/images/defaul_pic_app.jpg";
  final CrudMethods _crud = CrudMethods();
  bool _isLoading = false;
  String _jobType = "env";
  Uint8List? _image;
  @override
  void dispose() {
    super.dispose();
    _eligibiltyController.dispose();
    _jobTitleController.dispose();
    _detailsController.dispose();
  }

  void addJobApp() async {
    setState(() {
      _isLoading = true;
    });
    if (_image == null) {
      final ByteData bytes = await rootBundle.load(defaultPicPath);
      _image = bytes.buffer.asUint8List();
    }
    String res = await _crud.addJob(
      file: _image!,
      jobTitle: _jobTitleController.text,
      details: _detailsController.text,
      eligibilty: _eligibiltyController.text,
      jobType: _jobType,
    );
    if (res == "success") {
      setState(() {
        _isLoading = false;
        showSnackBar(context, "تم النشر بنجـاح");
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const MainPage()));
      });
    } else {
      setState(() {
        _isLoading = false;
        showSnackBar(context, res);
      });
    }
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void onUserTypeChanged(String? userType) {
    if (userType is String) {
      setState(() {
        _jobType = userType;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: backgroundColor,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_rounded,
                    size: 30, color: notActiveColor),
              ),
              title: getLogo(35),
              centerTitle: true,
            ),
            body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height,
                          minWidth: MediaQuery.of(context).size.width),
                      child: IntrinsicHeight(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 24),
                          Stack(
                            children: [
                              _image != null
                                  ? SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          50.0,
                                      child: Image.memory(_image!),
                                    )
                                  : SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          50.0,
                                      child: Image.asset(
                                          "assests/images/defaul_pic_app.jpg"),
                                    ),
                              Positioned(
                                  bottom: -12,
                                  left: -5,
                                  child: IconButton(
                                    onPressed: () {
                                      selectImage();
                                    },
                                    icon: const Icon(
                                      Icons.add_a_photo_rounded,
                                      size: 30.0,
                                    ),
                                  ))
                            ],
                          ),
                          const SizedBox(height: 24),
                          TextFieldInput(
                            textEditingController: _jobTitleController,
                            hintText: "اسم العمل التطوعى",
                            textInputType: TextInputType.name,
                            textDirection: TextDirection.rtl,
                          ),
                          const SizedBox(height: 24),
                          LargeTextFieldInput(
                            textEditingController: _detailsController,
                            hintText: "تفاصيل العمل التطوعى",
                          ),
                          const SizedBox(height: 24),
                          LargeTextFieldInput(
                            textEditingController: _eligibiltyController,
                            hintText: "شروط العمل التطوعى",
                          ),
                          const SizedBox(height: 24),
                          DropdownButton(
                              iconSize: 32.0,
                              iconEnabledColor: Colors.red,
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(
                                  value: "env",
                                  child: Text("بيئـة"),
                                ),
                                DropdownMenuItem(
                                  value: "society",
                                  child: Text("مجتمـع"),
                                ),
                                DropdownMenuItem(
                                  value: "wild",
                                  child: Text("بريـة"),
                                ),
                                DropdownMenuItem(
                                  value: "disabled",
                                  child: Text("ذوى الهمم"),
                                ),
                              ],
                              value: _jobType,
                              onChanged: onUserTypeChanged),
                          const SizedBox(height: 24),
                          InkWell(
                            child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                  color: Colors.red,
                                ),
                                child: _isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white)
                                    : const Text("نشـر تطوع",
                                        style: TextStyle(color: Colors.white))),
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              addJobApp();
                            },
                          ),
                        ],
                      ))),
                ))));
  }
}
