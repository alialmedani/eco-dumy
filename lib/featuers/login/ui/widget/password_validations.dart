// import 'package:ad_fluuter/core/helbers/spacing.dart';
// import 'package:ad_fluuter/core/theming/clolors.dart';
// import 'package:ad_fluuter/core/theming/styles.dart';
// import 'package:ad_fluuter/generated/l10n.dart';
// import 'package:flutter/material.dart';

// class PasswordValidations extends StatelessWidget {
//   final bool hasLowerCase;
//   final bool hasUpperCase;
//   final bool hasNumber;
//   final bool hasSpecialCharacters;
//   final bool hasMinLeangth;

//   const PasswordValidations(
//       {super.key,
//       required this.hasLowerCase,
//       required this.hasUpperCase,
//       required this.hasNumber,
//       required this.hasSpecialCharacters,
//       required this.hasMinLeangth});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         bulValidationRow(S.current.At_least_lowercase_letter, hasLowerCase),
//         verticalSpace(2),
//         bulValidationRow(S.current.At_least_uppercase_letter, hasUpperCase),
//         verticalSpace(2),
//         bulValidationRow(
//             S.current.At_least_speacial_character, hasSpecialCharacters),
//         verticalSpace(2),
//         bulValidationRow(S.current.At_least_number, hasNumber),
//         verticalSpace(2),
//         bulValidationRow(S.current.At_least_character, hasMinLeangth),
//         verticalSpace(2),
//       ],
//     );
//   }

//   Widget bulValidationRow(String text, bool hasValidated) {
//     return Builder(
//       builder: (context) {
//         final isDark = Theme.of(context).brightness == Brightness.dark;

//         return Row(
//           children: [
//             CircleAvatar(
//               radius: 2.5,
//               backgroundColor: isDark ? Colors.white : ColorsManager.gray,
//             ),
//             horizontalSpace(6),
//             Text(
//               text,
//               style: TextStyles.font13DarkBlueRegular1.copyWith(
//                 decoration: hasValidated ? TextDecoration.lineThrough : null,
//                 decorationColor: Colors.green,
//                 decorationThickness: 2,
//                 color:
//                     hasValidated ? ColorsManager.gray : ColorsManager.white,
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }
// }
