import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/core/utils/functions/reg_exp.dart';
 import 'package:flutter/material.dart';
 

class AppValidators {
  static String? validateFillFields(BuildContext context, String? name) {
    if (name == null || name.isEmpty) {
      return "fill_field".tr();
    }
    return null;
  }

  static String? validatePasswordFields(
      BuildContext context, String? password) {
    if (password == null || password.isEmpty) {
      return "fill_field".tr();
    } else if (AppRegexp.passwordRegex.hasMatch(password) == false) {
      return "password_regexp".tr();
    }
    return null;
  }

  static String? validateRepeatPasswordFields(
      BuildContext context, String? password, String? repeatedPassword) {
    if (repeatedPassword == null || repeatedPassword.isEmpty) {
      return  "fill_field".tr();
    }
    if (password != repeatedPassword) {
      return  " must_same_password".tr();
    }
    return null;
  }

  static String? validateEmailFields(BuildContext context, String? email) {
    if (email == null || email.isEmpty) {
      return  "fill_field".tr();
    } else if (AppRegexp.emailRegexp.hasMatch(email) == false) {
      return "email_regexp";
    }
    return null;
  }

  static String? validatePhoneFields(BuildContext context, String? phone) {
    if (phone == null || phone.isEmpty) {
      return  "fill_field".tr();
    }
    if (AppRegexp.phoneRegexp.hasMatch(phone) == false) {
      return "phone_regexp";
    }
    return null;
  }
}
