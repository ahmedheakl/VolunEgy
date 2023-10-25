import 'dart:typed_data';
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:volun/providers/user_provider.dart";
import "package:volun/resources/auth_methods.dart";
import "package:volun/utils/logo.dart";
import "package:volun/components/text_field_input.dart";
import "package:volun/utils/utils.dart";
import "package:image_picker/image_picker.dart";
import "package:volun/utils/globals.dart";
import "package:volun/pages/profile_page.dart";

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _qualificationController =
      TextEditingController();
  bool _isLoading = true;
  String _userType = "company";
  Uint8List? _image;
  String? _photoUrl;
  UserProvider? userProvider;

  @override
  void initState() {
    super.initState();
    AuthMethods().getUserDetails().then((user) {
      setState(() {
        _isLoading = false;
        _emailController.text = user.email;
        _nameController.text = user.name;
        _addressController.text = user.address;
        _phoneController.text = user.phone;
        _ageController.text = user.age;
        _qualificationController.text = user.qualification;
        _userType = user.type;
        _photoUrl = user.photoUrl;
      });
    });
    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _qualificationController.dispose();
  }

  Future<bool> editUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().editUser(
      email: _emailController.text,
      name: _nameController.text,
      type: _userType,
      phone: _phoneController.text,
      address: _addressController.text,
      age: _ageController.text,
      qualification: _qualificationController.text,
      file: _image,
      photoURL: _photoUrl,
    );
    if (res == "success") {
      await userProvider!.refreshUser();
      setState(() {
        _isLoading = false;
        showSnackBar(context, "تم تعديل الحساب بنجاح",
            textDirection: TextDirection.rtl);
      });
      moveToProfilePage();

      return true;
    }
    setState(() {
      _isLoading = false;
      showSnackBar(context, res);
    });
    return false;
  }

  void moveToProfilePage() {
    Navigator.of(context).pop();
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
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Container(
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
                                    : CircleAvatar(
                                        radius: 64,
                                        backgroundImage:
                                            NetworkImage(_photoUrl!),
                                        backgroundColor: Colors.red,
                                      ),
                                Positioned(
                                    bottom: -10,
                                    right: 100,
                                    child: IconButton(
                                      onPressed: () {
                                        selectImage();
                                      },
                                      icon:
                                          const Icon(Icons.add_a_photo_rounded),
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
                              readOnly: true,
                              textDirection: TextDirection.ltr,
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
                                      : const Text("تعديل حســاب",
                                          style:
                                              TextStyle(color: Colors.white))),
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                editUser();
                              },
                            ),
                            const Padding(padding: EdgeInsets.only(top: 24)),
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
