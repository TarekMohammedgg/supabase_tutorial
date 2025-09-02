import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_tutorial/utils/utils/app_router.dart';
import 'package:supabase_tutorial/utils/utils/app_style.dart';
import 'package:supabase_tutorial/widgets/custom_text_button.dart';
import 'package:supabase_tutorial/widgets/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController registerEmailController = TextEditingController();

  final TextEditingController registerPasswordController =
      TextEditingController();
  final TextEditingController registerUserNameController =
      TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> registerFormKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.go(AppRouter.kLoginScreen),
          icon: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black),
        ),
        centerTitle: true,
        title: Text("Sign Up", style: AppStyle.styleBold18),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: registerFormKey,
            child: Column(
              children: [
                SizedBox(height: 12),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: registerUserNameController,
                        hintText: "Name",
                      ),
                      SizedBox(height: 12),

                      CustomTextFormField(
                        controller: registerEmailController,
                        hintText: "Email",
                      ),
                      SizedBox(height: 12),
                      CustomTextFormField(
                        controller: registerPasswordController,
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
                                "Register",
                                textAlign: TextAlign.center,
                                style: AppStyle.stylebold16,
                              ),
                        onPressed: () async {},
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
