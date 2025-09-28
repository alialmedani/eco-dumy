// import 'package:ad_fluuter/core/helbers/spacing.dart';
// import 'package:ad_fluuter/core/theming/styles.dart';
// import 'package:ad_fluuter/core/widgets/app_text_button.dart';
// import 'package:ad_fluuter/featuers/login/logic/cubit/login_cubit.dart';
// import 'package:ad_fluuter/featuers/login/ui/widget/dont_have_account_text.dart';
// import 'package:ad_fluuter/featuers/login/ui/widget/email_and_password.dart';
// import 'package:ad_fluuter/featuers/login/ui/widget/login_bloc_listener.dart';
// import 'package:ad_fluuter/featuers/login/ui/widget/terms_and_condations_text.dart';
// import 'package:ad_fluuter/generated/l10n.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
//         child: SingleChildScrollView(
//             child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               S.current.Welcome_back,
//               style: TextStyles(context).font24BMainBold(context),
//             ),
//             verticalSpace(8),
//             Text(
//               S.current.Were_excited_to_have_you_back,
//               style: TextStyles(context).font14GrayRegular(context),
//             ),
//             verticalSpace(36),
//             Column(
//               children: [
//                 const EmailAndPassword(),
//                 //   Align(
//                 //     alignment: AlignmentDirectional.centerEnd,
//                 //     child: Row(
//                 //       children: [
//                 //         Checkbox(
//                 //           value: false,
//                 //           onChanged: (value) {},
//                 //         ), Text(
//                 //       "Remember Me",
//                 // style: TextStyles(context).font13BlueRegular(context) ,
//                 //     ),
//                 //       ],
//                 //     ),
//                 //   ),
//                 verticalSpace(70),
//                 AppTextButton(
//                     buttonText: S.of(context).Login,
//                     textStyle: TextStyles(context).font16WhiteSemiBold(context),
//                     onPressed: () {
//                       validateThenDoLgin(context);
//                     }),
//                 verticalSpace(16),
//                 const TermsAndCondationsText(),
//                 verticalSpace(60),
//                 const DontHaveAccountText(),
//                 const LoginBlocListener(),
//               ],
//             )
//           ],
//         )),
//       )),
//     );
//   }
// }

// void validateThenDoLgin(BuildContext context) {
//   if (context.read<LoginCubit>().formKey.currentState!.validate()) {
//     context.read<LoginCubit>().emitLogInStates();
//   }
// }
