import "package:flutter/material.dart";
import "package:volun/pages/signup_page.dart";
import "package:volun/utils/logo.dart";
import "package:volun/components/text_field_input.dart";
import "package:volun/components/password_field_input.dart";
import "package:volun/utils/utils.dart";
import "package:volun/resources/auth_methods.dart";
import "package:volun/pages/main_page.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void navigate() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainPage()));
  }

  void navigateToSignUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignUpPage()));
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (res == "success") {
      navigate();
      setState(() {
        _isLoading = false;
        showSnackBar(context, "Logged in.");
      });
    } else {
      setState(() {
        _isLoading = false;
        showSnackBar(context, res);
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 2, child: Container()),
              getLogo(28),
              const SizedBox(height: 54),
              TextFieldInput(
                textEditingController: _emailController,
                hintText: "عنوانك البريدى",
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              PasswordFieldInput(
                textEditingController: _passwordController,
                hintText: "كلمة السر",
              ),
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
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("تسجيل الدخــول",
                            style: TextStyle(color: Colors.white))),
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  loginUser();
                },
              ),
              Flexible(flex: 2, child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        navigateToSignUp();
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: const Text(
                            "سجل الآن.",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ))),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: const Text("لا تمتلك حسابا؟ ",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 18))),
                ],
              ),
            ],
          )),
    ));
  }
}
