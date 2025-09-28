// import 'package:ad_fluuter/core/helbers/extentions.dart';
// import 'package:ad_fluuter/core/routing/routrs.dart';
// import 'package:ad_fluuter/core/theming/styles.dart';
// import 'package:ad_fluuter/generated/l10n.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/widgets.dart';

// class DontHaveAccountText extends StatelessWidget {
//   const DontHaveAccountText({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return RichText(
//       textAlign: TextAlign.center,
//       text: TextSpan(
//         children: [
//           TextSpan(
//             text: S.current.Dont_have_an_account,
//             style: TextStyles(context).font13DarkBlueRegular(context),
//           ),
//           TextSpan(
//             text: S.current.Sign_Up,
//             style: TextStyles(context).font13BlueSemiBold(context),
//             recognizer: TapGestureRecognizer()
//               ..onTap = () {
//                 context.pushReplacementNamed(Routes.signUpScreen);
//               },
//           ),
//         ],
//       ),
//     );
//   }
// }
