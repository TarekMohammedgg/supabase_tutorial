import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_tutorial/utils/utils/app_images.dart';
import 'package:supabase_tutorial/utils/utils/app_router.dart';
import 'package:supabase_tutorial/utils/utils/app_style.dart';
import 'package:supabase_tutorial/widgets/custom_text_button.dart';
import 'package:supabase_tutorial/widgets/custom_text_form_field.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController loginEmailController = TextEditingController();

  final TextEditingController loginPasswordController = TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> signInFormKey = GlobalKey();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: signInFormKey,
            child: Column(
              children: [
                Image.asset(Assets.imagesWelcomeImage),
                SizedBox(height: 20),

                Text("Welcome back", style: AppStyle.styleBold28),
                SizedBox(height: 12),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: loginEmailController,
                        hintText: "Email",
                      ),
                      SizedBox(height: 20),
                      CustomTextFormField(
                        controller: loginPasswordController,
                        hintText: "Password",
                      ),

                      CustomTextButton(
                        widgt: isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                "Login",
                                textAlign: TextAlign.center,
                                style: AppStyle.stylebold16,
                              ),
                        onPressed: ()  {
                         
                        },
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: AppStyle.styleRegular16.copyWith(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              context.go(AppRouter.kRegisterScreenn);
                            },
                            child: Text(
                              "Register",
                              style: AppStyle.styleRegular16.copyWith(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
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
