import 'dart:typed_data';
import "package:flutter/material.dart";
import "package:volun/pages/login_page.dart";
import "package:volun/pages/main_page.dart";
import "package:volun/resources/auth_methods.dart";
import "package:volun/utils/logo.dart";
import "package:volun/components/text_field_input.dart";
import "package:volun/components/password_field_input.dart";
import "package:volun/utils/utils.dart";
import "package:image_picker/image_picker.dart";
import "package:volun/utils/globals.dart";

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _qualificationController =
      TextEditingController();
  bool _isLoading = false;
  String _userType = "company";
  Uint8List? _image;
  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    if (_image == null) {
      setState(() {
        _isLoading = false;
        showSnackBar(context, "قم باختيار الصورة لتسجيل الدخول");
      });
      return;
    }
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      file: _image!,
      type: _userType,
      phone: _phoneController.text,
      address: _addressController.text,
      age: _ageController.text,
      qualification: _qualificationController.text,
    );
    if (res == "success") {
      setState(() {
        _isLoading = false;
        showSnackBar(context, "تم تسجيل الحساب بنجاح");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainPage()));
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
        _userType = userType;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Container(
            decoration: const BoxDecoration(color: backgroundColor),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      getLogo(35),
                      const SizedBox(height: 24),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          _image != null
                              ? CircleAvatar(
                                  radius: 64,
                                  backgroundImage: MemoryImage(_image!),
                                  backgroundColor: Colors.red,
                                )
                              : const CircleAvatar(
                                  radius: 64,
                                  backgroundImage: NetworkImage(
                                      'https://i.stack.imgur.com/l60Hf.png'),
                                  backgroundColor: Colors.red,
                                ),
                          Positioned(
                              bottom: -10,
                              right: 100,
                              child: IconButton(
                                onPressed: () {
                                  selectImage();
                                },
                                icon: const Icon(Icons.add_a_photo_rounded),
                              ))
                        ],
                      ),
                      const SizedBox(height: 24),
                      TextFieldInput(
                        textEditingController: _nameController,
                        hintText: "الإسم",
                        textInputType: TextInputType.name,
                      ),
                      const SizedBox(height: 24),
                      TextFieldInput(
                        textEditingController: _emailController,
                        hintText: "البريد الالكترونى",
                        textInputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 24),
                      PasswordFieldInput(
                        textEditingController: _passwordController,
                        hintText: "كلمة الســر",
                      ),
                      const SizedBox(height: 24),
                      TextFieldInput(
                        textEditingController: _phoneController,
                        hintText: "رقم التليــفون",
                        textInputType: TextInputType.phone,
                      ),
                      const SizedBox(height: 24),
                      TextFieldInput(
                        textEditingController: _ageController,
                        hintText: "العمـر",
                        textInputType: TextInputType.number,
                      ),
                      const SizedBox(height: 24),
                      TextFieldInput(
                        textEditingController: _addressController,
                        hintText: "العنـــوان",
                        textInputType: TextInputType.streetAddress,
                      ),
                      const SizedBox(height: 24),
                      TextFieldInput(
                        textEditingController: _qualificationController,
                        hintText: "المـــؤهل",
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(height: 24),
                      DropdownButton(
                          iconSize: 32.0,
                          iconEnabledColor: Colors.red,
                          isExpanded: true,
                          items: const [
                            DropdownMenuItem(
                              value: "company",
                              child: Text("شركـة"),
                            ),
                            DropdownMenuItem(
                              value: "volunteer",
                              child: Text("متطــوع"),
                            ),
                          ],
                          value: _userType,
                          onChanged: onUserTypeChanged),
                      const SizedBox(height: 24),
                      InkWell(
                        child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              color: Colors.red,
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text("تسجيل حســاب",
                                    style: TextStyle(color: Colors.white))),
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          signUpUser();
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));
                              },
                              child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: const Text(
                                    "سجل الدخول. ",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ))),
                          Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: const Text("تمتلك حسابا؟ ",
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(fontSize: 18))),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
