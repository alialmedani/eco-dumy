import 'package:eco_dumy/core/utils/functions/reg_exp.dart';
import 'package:eco_dumy/generated/l10n.dart';
import 'package:flutter/material.dart';
 

class AppValidators {
  static String? validateFillFields(BuildContext context, String? name) {
    if (name == null || name.isEmpty) {
      return S.of(context).fill_field;
    }
    return null;
  }

  static String? validatePasswordFields(
      BuildContext context, String? password) {
    if (password == null || password.isEmpty) {
      return S.of(context).fill_field;
    } else if (AppRegexp.passwordRegex.hasMatch(password) == false) {
      return "password_regexp";
    }
    return null;
  }

  static String? validateRepeatPasswordFields(
      BuildContext context, String? password, String? repeatedPassword) {
    if (repeatedPassword == null || repeatedPassword.isEmpty) {
      return S.of(context).fill_field;
    }
    if (password != repeatedPassword) {
      return S.of(context).must_same_password;
    }
    return null;
  }

  static String? validateEmailFields(BuildContext context, String? email) {
    if (email == null || email.isEmpty) {
      return S.of(context).fill_field;
    } else if (AppRegexp.emailRegexp.hasMatch(email) == false) {
      return "email_regexp";
    }
    return null;
  }

  static String? validatePhoneFields(BuildContext context, String? phone) {
    if (phone == null || phone.isEmpty) {
      return S.of(context).fill_field;
    }
    if (AppRegexp.phoneRegexp.hasMatch(phone) == false) {
      return "phone_regexp";
    }
    return null;
  }
}
