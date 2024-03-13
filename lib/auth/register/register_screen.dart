import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/auth/custom_text_form_field.dart';
import 'package:to_do_application/auth/login/login.dart';
import 'package:to_do_application/auth/my_validation.dart';
import '../../Providers/settings-provider.dart';
import '../../my_theme.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController PasswordConfirmationController =
      TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);

    return Container(
        decoration: BoxDecoration(
            color: provider.isDarkMode() ? MyTheme.darkBody : MyTheme.lightBody,
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.fill,
            )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextFormField(
                    controller: fullNameController,
                    validation: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "enter valid name";
                      }
                    },
                    labelText: "Full Name",
                  ),
                  CustomTextFormField(
                    controller: EmailController,
                    validation: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "enter valid email";
                      }
                      if (!MyValidations.isValidEmail(text)) {
                        return "enter valid email";
                      }
                    },
                    labelText: "Email Address",
                  ),
                  CustomTextFormField(
                    controller: PasswordController,
                    validation: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "enter valid password";
                      }
                      if (text.length < 6) {
                        return "enter valid password";
                      }
                    },
                    labelText: "Password",
                  ),
                  CustomTextFormField(
                    controller: PasswordConfirmationController,
                    validation: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "enter valid email";
                      }
                      if (PasswordController.text != text) {
                        return "password dos't match";
                      }
                    },
                    labelText: "Confirm Password",
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      onPressed: () {
                        register();
                      },
                      child: Text(
                        "Create Account",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, LoginScreen.routeName);
                      },
                      child: Text(
                        "Already have Account",
                      ))
                ],
              ),
            ),
          ),
        ));
  }

  void register() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: EmailController.text.trim(),
        password: PasswordController.text.trim(),
      );
      print('successfully register');
      print('User id ==> ${credential.user?.uid}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    //Navigator.pushNamed(context, HomeScreen.routeName);
  }
}
