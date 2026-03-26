import 'package:flutter/material.dart';
import 'package:flutter_application_7/user_info_page.dart';
import 'package:easy_localization/easy_localization.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  final nameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();
  final phoneFocus = FocusNode();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();

    nameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    phoneFocus.dispose();

    super.dispose();
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserInfoPage(
            name: nameController.text,
            email: emailController.text,
            phone: phoneController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("registration_page".tr()),
        actions: [
          IconButton(
            icon: Text("EN"),
            onPressed: () => context.setLocale(const Locale('en')),
          ),
          IconButton(
            icon: Text("RU"),
            onPressed: () => context.setLocale(const Locale('ru')),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                focusNode: nameFocus,
                decoration: InputDecoration(
                  labelText: "name".tr(),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "name_empty".tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: emailController,
                focusNode: emailFocus,
                decoration: InputDecoration(
                  labelText: "email".tr(),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "email_empty".tr();
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return "email_invalid".tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: phoneController,
                focusNode: phoneFocus,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "phone".tr(),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "phone_empty".tr();
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return "phone_invalid".tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: passwordController,
                focusNode: passwordFocus,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  labelText: "password".tr(),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "password_empty".tr();
                  }
                  if (value.length < 6) {
                    return "password_short".tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: confirmPasswordController,
                focusNode: confirmPasswordFocus,
                obscureText: obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: "confirm_password".tr(),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureConfirmPassword = !obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value != passwordController.text) {
                    return "password_mismatch".tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: submitForm,
                child: Text("register".tr()),
              )
            ],
          ),
        ),
      ),
    );
  }
}