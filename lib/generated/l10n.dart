// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Brands`
  String get Brands {
    return Intl.message(
      'Brands',
      name: 'Brands',
      desc: '',
      args: [],
    );
  }

  /// `See more`
  String get See_more {
    return Intl.message(
      'See more',
      name: 'See_more',
      desc: '',
      args: [],
    );
  }

  /// `Most Sold`
  String get Most_Sold {
    return Intl.message(
      'Most Sold',
      name: 'Most_Sold',
      desc: '',
      args: [],
    );
  }

  /// `Highend Brand`
  String get Highend_Brand {
    return Intl.message(
      'Highend Brand',
      name: 'Highend_Brand',
      desc: '',
      args: [],
    );
  }

  /// `I have accepted the`
  String get terms1 {
    return Intl.message(
      'I have accepted the',
      name: 'terms1',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get terms2 {
    return Intl.message(
      'Terms and Conditions',
      name: 'terms2',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get Gender {
    return Intl.message(
      'Gender',
      name: 'Gender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get Male {
    return Intl.message(
      'Male',
      name: 'Male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get Female {
    return Intl.message(
      'Female',
      name: 'Female',
      desc: '',
      args: [],
    );
  }

  /// `verification code`
  String get verification_code {
    return Intl.message(
      'verification code',
      name: 'verification_code',
      desc: '',
      args: [],
    );
  }

  /// `We have sent a verification code to your phone`
  String get sent_verification {
    return Intl.message(
      'We have sent a verification code to your phone',
      name: 'sent_verification',
      desc: '',
      args: [],
    );
  }

  /// `Resend the code`
  String get Resend_code {
    return Intl.message(
      'Resend the code',
      name: 'Resend_code',
      desc: '',
      args: [],
    );
  }

  /// `has been changed Successfully`
  String get changed {
    return Intl.message(
      'has been changed Successfully',
      name: 'changed',
      desc: '',
      args: [],
    );
  }

  /// `verification`
  String get verification {
    return Intl.message(
      'verification',
      name: 'verification',
      desc: '',
      args: [],
    );
  }

  /// `Code Send Successfully`
  String get send_code_success {
    return Intl.message(
      'Code Send Successfully',
      name: 'send_code_success',
      desc: '',
      args: [],
    );
  }

  /// `Verify your Number`
  String get Verify_your_Number {
    return Intl.message(
      'Verify your Number',
      name: 'Verify_your_Number',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password`
  String get Forget_Password {
    return Intl.message(
      'Forget Password',
      name: 'Forget_Password',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get Phone {
    return Intl.message(
      'Phone',
      name: 'Phone',
      desc: '',
      args: [],
    );
  }

  /// `Enter your number`
  String get Enter_your_number {
    return Intl.message(
      'Enter your number',
      name: 'Enter_your_number',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get SignIn {
    return Intl.message(
      'Sign In',
      name: 'SignIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to your account to enjoy a unique shopping experience on the Jedar Store and get more features`
  String get SignIn_title {
    return Intl.message(
      'Sign in to your account to enjoy a unique shopping experience on the Jedar Store and get more features',
      name: 'SignIn_title',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get User_Name {
    return Intl.message(
      'User Name',
      name: 'User_Name',
      desc: '',
      args: [],
    );
  }

  /// `Enter your user name`
  String get Enter_user {
    return Intl.message(
      'Enter your user name',
      name: 'Enter_user',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get Enter_password {
    return Intl.message(
      'Enter your password',
      name: 'Enter_password',
      desc: '',
      args: [],
    );
  }

  /// `you are not verfied`
  String get not_verfied {
    return Intl.message(
      'you are not verfied',
      name: 'not_verfied',
      desc: '',
      args: [],
    );
  }

  /// `dont Have Account!?`
  String get dont_Have_Account {
    return Intl.message(
      'dont Have Account!?',
      name: 'dont_Have_Account',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get Create_Account {
    return Intl.message(
      'Create Account',
      name: 'Create_Account',
      desc: '',
      args: [],
    );
  }

  /// `Signup`
  String get Signup {
    return Intl.message(
      'Signup',
      name: 'Signup',
      desc: '',
      args: [],
    );
  }

  /// `welcome`
  String get welcome {
    return Intl.message(
      'welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your full name`
  String get First_Name {
    return Intl.message(
      'Please enter your full name',
      name: 'First_Name',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get Last_Name {
    return Intl.message(
      'Last Name',
      name: 'Last_Name',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get Next {
    return Intl.message(
      'Next',
      name: 'Next',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get Cart {
    return Intl.message(
      'Cart',
      name: 'Cart',
      desc: '',
      args: [],
    );
  }

  /// `Your Cart Is Empty`
  String get Cart_Empty {
    return Intl.message(
      'Your Cart Is Empty',
      name: 'Cart_Empty',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get Total {
    return Intl.message(
      'Total',
      name: 'Total',
      desc: '',
      args: [],
    );
  }

  /// `Discount Value`
  String get Discount_Value {
    return Intl.message(
      'Discount Value',
      name: 'Discount_Value',
      desc: '',
      args: [],
    );
  }

  /// `Enter the Promocode`
  String get Enter_Code {
    return Intl.message(
      'Enter the Promocode',
      name: 'Enter_Code',
      desc: '',
      args: [],
    );
  }

  /// `Apply Code`
  String get Apply_Code {
    return Intl.message(
      'Apply Code',
      name: 'Apply_Code',
      desc: '',
      args: [],
    );
  }

  /// `Net Total: `
  String get Net_Total {
    return Intl.message(
      'Net Total: ',
      name: 'Net_Total',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get Pay {
    return Intl.message(
      'Pay',
      name: 'Pay',
      desc: '',
      args: [],
    );
  }

  /// `Note the delivery fees to Baghdad 5000 provinces 8000`
  String get cart_note {
    return Intl.message(
      'Note the delivery fees to Baghdad 5000 provinces 8000',
      name: 'cart_note',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get Confirm {
    return Intl.message(
      'Confirm',
      name: 'Confirm',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Home {
    return Intl.message(
      'Home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `Offers`
  String get Offers {
    return Intl.message(
      'Offers',
      name: 'Offers',
      desc: '',
      args: [],
    );
  }

  /// `My Cart`
  String get My_Cart {
    return Intl.message(
      'My Cart',
      name: 'My_Cart',
      desc: '',
      args: [],
    );
  }

  /// `Wishlist`
  String get Wishlist {
    return Intl.message(
      'Wishlist',
      name: 'Wishlist',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get Shopping {
    return Intl.message(
      'Category',
      name: 'Shopping',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get Settings {
    return Intl.message(
      'Settings',
      name: 'Settings',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get Search {
    return Intl.message(
      'Search',
      name: 'Search',
      desc: '',
      args: [],
    );
  }

  /// `YAY! YOU ARE HERE`
  String get YOU_ARE_HERE {
    return Intl.message(
      'YAY! YOU ARE HERE',
      name: 'YOU_ARE_HERE',
      desc: '',
      args: [],
    );
  }

  /// `Hi, Beauteful!`
  String get Hi {
    return Intl.message(
      'Hi, Beauteful!',
      name: 'Hi',
      desc: '',
      args: [],
    );
  }

  /// `Discover`
  String get Discover {
    return Intl.message(
      'Discover',
      name: 'Discover',
      desc: '',
      args: [],
    );
  }

  /// `My WishList`
  String get My_WishList {
    return Intl.message(
      'My WishList',
      name: 'My_WishList',
      desc: '',
      args: [],
    );
  }

  /// `Remove all`
  String get remove {
    return Intl.message(
      'Remove all',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get My_Orders {
    return Intl.message(
      'My Orders',
      name: 'My_Orders',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get Favorite {
    return Intl.message(
      'Favorite',
      name: 'Favorite',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get Change_Password {
    return Intl.message(
      'Change Password',
      name: 'Change_Password',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get Change_Language {
    return Intl.message(
      'Change Language',
      name: 'Change_Language',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get About {
    return Intl.message(
      'About',
      name: 'About',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get Contact_Us {
    return Intl.message(
      'Contact Us',
      name: 'Contact_Us',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get Old_password {
    return Intl.message(
      'Old Password',
      name: 'Old_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get Confirm_Password {
    return Intl.message(
      'Confirm Password',
      name: 'Confirm_Password',
      desc: '',
      args: [],
    );
  }

  /// `Enter your confirmed password`
  String get Enter_confirmed_password {
    return Intl.message(
      'Enter your confirmed password',
      name: 'Enter_confirmed_password',
      desc: '',
      args: [],
    );
  }

  /// `your password has been added successfully`
  String get password_successfully {
    return Intl.message(
      'your password has been added successfully',
      name: 'password_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get Save {
    return Intl.message(
      'Save',
      name: 'Save',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get English {
    return Intl.message(
      'English',
      name: 'English',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get Arabic {
    return Intl.message(
      'Arabic',
      name: 'Arabic',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get Email {
    return Intl.message(
      'Email',
      name: 'Email',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get Logout {
    return Intl.message(
      'Logout',
      name: 'Logout',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get try_again {
    return Intl.message(
      'Try Again',
      name: 'try_again',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Original 100%`
  String get Original {
    return Intl.message(
      'Original 100%',
      name: 'Original',
      desc: '',
      args: [],
    );
  }

  /// `click here to see more product of this brand`
  String get click_here {
    return Intl.message(
      'click here to see more product of this brand',
      name: 'click_here',
      desc: '',
      args: [],
    );
  }

  /// `Colors `
  String get Colors {
    return Intl.message(
      'Colors ',
      name: 'Colors',
      desc: '',
      args: [],
    );
  }

  /// `how use it`
  String get how_use_it {
    return Intl.message(
      'how use it',
      name: 'how_use_it',
      desc: '',
      args: [],
    );
  }

  /// `specifications`
  String get specifications {
    return Intl.message(
      'specifications',
      name: 'specifications',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get Reviews {
    return Intl.message(
      'Reviews',
      name: 'Reviews',
      desc: '',
      args: [],
    );
  }

  /// `Add To Cart`
  String get Add_To_Cart {
    return Intl.message(
      'Add To Cart',
      name: 'Add_To_Cart',
      desc: '',
      args: [],
    );
  }

  /// `Product added to cart`
  String get Product_added {
    return Intl.message(
      'Product added to cart',
      name: 'Product_added',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while searching. Try again.`
  String get error_search {
    return Intl.message(
      'An error occurred while searching. Try again.',
      name: 'error_search',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get Reset {
    return Intl.message(
      'Reset',
      name: 'Reset',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get Apply {
    return Intl.message(
      'Apply',
      name: 'Apply',
      desc: '',
      args: [],
    );
  }

  /// `Sort`
  String get Sort {
    return Intl.message(
      'Sort',
      name: 'Sort',
      desc: '',
      args: [],
    );
  }

  /// `Price Range`
  String get Price_Range {
    return Intl.message(
      'Price Range',
      name: 'Price_Range',
      desc: '',
      args: [],
    );
  }

  /// `Min`
  String get Min {
    return Intl.message(
      'Min',
      name: 'Min',
      desc: '',
      args: [],
    );
  }

  /// `Max`
  String get Max {
    return Intl.message(
      'Max',
      name: 'Max',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get Price {
    return Intl.message(
      'Price',
      name: 'Price',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get Discount {
    return Intl.message(
      'Discount',
      name: 'Discount',
      desc: '',
      args: [],
    );
  }

  /// `Confirm deletion`
  String get Confirm_deletion {
    return Intl.message(
      'Confirm deletion',
      name: 'Confirm_deletion',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to remove this product from the cart?`
  String get Confirm_deletion_title {
    return Intl.message(
      'Do you want to remove this product from the cart?',
      name: 'Confirm_deletion_title',
      desc: '',
      args: [],
    );
  }

  /// `Cancle`
  String get Cancle {
    return Intl.message(
      'Cancle',
      name: 'Cancle',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get Delete {
    return Intl.message(
      'Delete',
      name: 'Delete',
      desc: '',
      args: [],
    );
  }

  /// `profile`
  String get profile {
    return Intl.message(
      'profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get Orders {
    return Intl.message(
      'Orders',
      name: 'Orders',
      desc: '',
      args: [],
    );
  }

  /// `Products you might like`
  String get Products_might_like {
    return Intl.message(
      'Products you might like',
      name: 'Products_might_like',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Beautiful!`
  String get Welcome_Beautiful {
    return Intl.message(
      'Welcome Beautiful!',
      name: 'Welcome_Beautiful',
      desc: '',
      args: [],
    );
  }

  /// `Current Orders`
  String get Current_Orders {
    return Intl.message(
      'Current Orders',
      name: 'Current_Orders',
      desc: '',
      args: [],
    );
  }

  /// `Previous Orders`
  String get Previous_Orders {
    return Intl.message(
      'Previous Orders',
      name: 'Previous_Orders',
      desc: '',
      args: [],
    );
  }

  /// `Order Number:`
  String get Order_Number {
    return Intl.message(
      'Order Number:',
      name: 'Order_Number',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get Color {
    return Intl.message(
      'Color',
      name: 'Color',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get Subtotal {
    return Intl.message(
      'Subtotal',
      name: 'Subtotal',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Charges`
  String get Delivery_Charges {
    return Intl.message(
      'Delivery Charges',
      name: 'Delivery_Charges',
      desc: '',
      args: [],
    );
  }

  /// `Service Fees`
  String get Service_Fees {
    return Intl.message(
      'Service Fees',
      name: 'Service_Fees',
      desc: '',
      args: [],
    );
  }

  /// `Total Amount`
  String get Total_Amount {
    return Intl.message(
      'Total Amount',
      name: 'Total_Amount',
      desc: '',
      args: [],
    );
  }

  /// `IQD`
  String get IQD {
    return Intl.message(
      'IQD',
      name: 'IQD',
      desc: '',
      args: [],
    );
  }

  /// `Sort by discount`
  String get Sort_by_discount {
    return Intl.message(
      'Sort by discount',
      name: 'Sort_by_discount',
      desc: '',
      args: [],
    );
  }

  /// `Sort by Price Desc`
  String get Sort_Price_Desc {
    return Intl.message(
      'Sort by Price Desc',
      name: 'Sort_Price_Desc',
      desc: '',
      args: [],
    );
  }

  /// `Sort by Price Ask`
  String get Sort_Price_Ask {
    return Intl.message(
      'Sort by Price Ask',
      name: 'Sort_Price_Ask',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Address`
  String get Enter_address {
    return Intl.message(
      'Enter your Address',
      name: 'Enter_address',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get Checkout {
    return Intl.message(
      'Checkout',
      name: 'Checkout',
      desc: '',
      args: [],
    );
  }

  /// `Pay through`
  String get Pay_through {
    return Intl.message(
      'Pay through',
      name: 'Pay_through',
      desc: '',
      args: [],
    );
  }

  /// `Cash payment`
  String get Cash_payment {
    return Intl.message(
      'Cash payment',
      name: 'Cash_payment',
      desc: '',
      args: [],
    );
  }

  /// `Payment Summary`
  String get Payment_Summary {
    return Intl.message(
      'Payment Summary',
      name: 'Payment_Summary',
      desc: '',
      args: [],
    );
  }

  /// `Submet`
  String get Submet {
    return Intl.message(
      'Submet',
      name: 'Submet',
      desc: '',
      args: [],
    );
  }

  /// `Please Login First`
  String get Please_Login_First {
    return Intl.message(
      'Please Login First',
      name: 'Please_Login_First',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get Success {
    return Intl.message(
      'Success',
      name: 'Success',
      desc: '',
      args: [],
    );
  }

  /// `fill field`
  String get fill_field {
    return Intl.message(
      'fill field',
      name: 'fill_field',
      desc: '',
      args: [],
    );
  }

  /// `must be same as password`
  String get must_same_password {
    return Intl.message(
      'must be same as password',
      name: 'must_same_password',
      desc: '',
      args: [],
    );
  }

  /// `The code entered is incorrect, please try again.`
  String get code_incorrect {
    return Intl.message(
      'The code entered is incorrect, please try again.',
      name: 'code_incorrect',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Addres`
  String get Shipping_Addres {
    return Intl.message(
      'Shipping Addres',
      name: 'Shipping_Addres',
      desc: '',
      args: [],
    );
  }

  /// `the promocode Actived Successfly`
  String get promocode_Successfly {
    return Intl.message(
      'the promocode Actived Successfly',
      name: 'promocode_Successfly',
      desc: '',
      args: [],
    );
  }

  /// `OTP Code Verification`
  String get OTP_Code_Verification {
    return Intl.message(
      'OTP Code Verification',
      name: 'OTP_Code_Verification',
      desc: '',
      args: [],
    );
  }

  /// `choose one of the methods beloow to get the OTP code.`
  String get choose_methods {
    return Intl.message(
      'choose one of the methods beloow to get the OTP code.',
      name: 'choose_methods',
      desc: '',
      args: [],
    );
  }

  /// `OTP Sended Success via WhatsApp`
  String get OTP_Sended_WhatsApp {
    return Intl.message(
      'OTP Sended Success via WhatsApp',
      name: 'OTP_Sended_WhatsApp',
      desc: '',
      args: [],
    );
  }

  /// `Send via WhatsApp`
  String get Send_via_WhatsApp {
    return Intl.message(
      'Send via WhatsApp',
      name: 'Send_via_WhatsApp',
      desc: '',
      args: [],
    );
  }

  /// `OTP Sended Success via SMS`
  String get OTP_Sended_SMS {
    return Intl.message(
      'OTP Sended Success via SMS',
      name: 'OTP_Sended_SMS',
      desc: '',
      args: [],
    );
  }

  /// `Send via SMS`
  String get Send_via_SMS {
    return Intl.message(
      'Send via SMS',
      name: 'Send_via_SMS',
      desc: '',
      args: [],
    );
  }

  /// `if nothing is chossen in 3 seconds, the code will be sent automatically vis WhatsApp`
  String get nothing_sent_automatically {
    return Intl.message(
      'if nothing is chossen in 3 seconds, the code will be sent automatically vis WhatsApp',
      name: 'nothing_sent_automatically',
      desc: '',
      args: [],
    );
  }

  /// `Registration Successful`
  String get Registration_Successful {
    return Intl.message(
      'Registration Successful',
      name: 'Registration_Successful',
      desc: '',
      args: [],
    );
  }

  /// `Wrong Code`
  String get Wrong_Code {
    return Intl.message(
      'Wrong Code',
      name: 'Wrong_Code',
      desc: '',
      args: [],
    );
  }

  /// `All Product`
  String get all_product {
    return Intl.message(
      'All Product',
      name: 'all_product',
      desc: '',
      args: [],
    );
  }

  /// `Some Thing went Wrong`
  String get Some_Wrong {
    return Intl.message(
      'Some Thing went Wrong',
      name: 'Some_Wrong',
      desc: '',
      args: [],
    );
  }

  /// `Product Name`
  String get product_name {
    return Intl.message(
      'Product Name',
      name: 'product_name',
      desc: '',
      args: [],
    );
  }

  /// `Please complete your order first`
  String get Please_complete_your_order_first {
    return Intl.message(
      'Please complete your order first',
      name: 'Please_complete_your_order_first',
      desc: '',
      args: [],
    );
  }

  /// `Governorate`
  String get Governorate {
    return Intl.message(
      'Governorate',
      name: 'Governorate',
      desc: '',
      args: [],
    );
  }

  /// `Enter Governorate`
  String get enter_Governorate {
    return Intl.message(
      'Enter Governorate',
      name: 'enter_Governorate',
      desc: '',
      args: [],
    );
  }

  /// `Region`
  String get Region {
    return Intl.message(
      'Region',
      name: 'Region',
      desc: '',
      args: [],
    );
  }

  /// `Enter Region`
  String get enter_Region {
    return Intl.message(
      'Enter Region',
      name: 'enter_Region',
      desc: '',
      args: [],
    );
  }

  /// `Nearest place`
  String get Nearest_place {
    return Intl.message(
      'Nearest place',
      name: 'Nearest_place',
      desc: '',
      args: [],
    );
  }

  /// `Enter the nearest point of reference to you`
  String get enter_Nearest_place {
    return Intl.message(
      'Enter the nearest point of reference to you',
      name: 'enter_Nearest_place',
      desc: '',
      args: [],
    );
  }

  /// `You can adjust the location of the buttons by pressing and holding and dragging them wherever you want`
  String get location_buttons {
    return Intl.message(
      'You can adjust the location of the buttons by pressing and holding and dragging them wherever you want',
      name: 'location_buttons',
      desc: '',
      args: [],
    );
  }

  /// `Invalid username or password!`
  String get Invalid_login {
    return Intl.message(
      'Invalid username or password!',
      name: 'Invalid_login',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid phone number`
  String get enter_valid_number {
    return Intl.message(
      'Please enter a valid phone number',
      name: 'enter_valid_number',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get confirm_password_not_match {
    return Intl.message(
      'Passwords do not match',
      name: 'confirm_password_not_match',
      desc: '',
      args: [],
    );
  }

  /// `old password not match`
  String get old_password_not_match {
    return Intl.message(
      'old password not match',
      name: 'old_password_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get Notifications {
    return Intl.message(
      'Notifications',
      name: 'Notifications',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get delete_account {
    return Intl.message(
      'Delete Account',
      name: 'delete_account',
      desc: '',
      args: [],
    );
  }

  /// `Account deleted successfully`
  String get account_deleted_successfully {
    return Intl.message(
      'Account deleted successfully',
      name: 'account_deleted_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Category Items`
  String get category_items {
    return Intl.message(
      'Category Items',
      name: 'category_items',
      desc: '',
      args: [],
    );
  }

  /// `Trending Product`
  String get trending_product {
    return Intl.message(
      'Trending Product',
      name: 'trending_product',
      desc: '',
      args: [],
    );
  }

  /// `Orders arrive in Baghdad Governorate within 24 hours of order confirmation. Other governorates receive orders within four days.`
  String get orders_arrive {
    return Intl.message(
      'Orders arrive in Baghdad Governorate within 24 hours of order confirmation. Other governorates receive orders within four days.',
      name: 'orders_arrive',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
