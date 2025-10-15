 
import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/featuers/auth/cubit/auth_cubit.dart';
import 'package:eco_dumy/featuers/auth/screen/widget/app_regex.dart';
import 'package:eco_dumy/featuers/auth/screen/widget/app_text_form_field.dart';
import 'package:eco_dumy/featuers/auth/screen/widget/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailAndPassword extends StatefulWidget {
  const   EmailAndPassword({super.key});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  bool hasLowerCase = false;
  bool hasUppercase = false;
  bool hasNumber = false;
  bool hasSpecialCharacters = false;
  bool hasMinLeangth = false;
  bool isObscureText = true;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    passwordController = context.read<AuthCubit>().passwordController;
    setUpPasswordController();
  }

  void setUpPasswordController() {
    passwordController.addListener(() {
      setState(() {
        hasLowerCase = AppRegex.hasLowerCase(passwordController.text);
        hasUppercase = AppRegex.hasUpperCase(passwordController.text);
        hasNumber = AppRegex.hasNumber(passwordController.text);
        hasSpecialCharacters = AppRegex.hasSpecialCharacter(
          passwordController.text,
        );
        hasMinLeangth = AppRegex.hasMinLength(passwordController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<AuthCubit>().formKey,
      child: Column(
        children: [
          AppTextFormField(
            hintText:  "Email".tr(),
            // validator: (value) {
            //   if (value == null ||
            //       value.isEmpty ||
            //       !AppRegex.isEmailValid(value)) {
            //     return 'Please Enter A Valid Email';
            //   }
            // },
            controller: context.read<AuthCubit>().emailController,
          ),
          verticalSpace(18),
          AppTextFormField(
            controller: context.read<AuthCubit>().passwordController,
            hintText: "Password".tr(),
            isObscureText: isObscureText,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isObscureText = !isObscureText;
                });
              },
              child: Icon(
                isObscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
          verticalSpace(24),
          // PasswordValidations(
          //   hasLowerCase: hasLowerCase,
          //   hasUpperCase: hasUppercase,
          //   hasNumber: hasNumber,
          //   hasSpecialCharacters: hasSpecialCharacters,
          //   hasMinLeangth: hasMinLeangth,
          // )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
  }
}
