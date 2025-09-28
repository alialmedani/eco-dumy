// import 'package:ad_fluuter/core/helbers/extentions.dart';
// import 'package:ad_fluuter/core/routing/routrs.dart';
// import 'package:ad_fluuter/core/theming/clolors.dart';
// import 'package:ad_fluuter/core/theming/styles.dart';
// import 'package:ad_fluuter/featuers/login/logic/cubit/login_cubit.dart';
// import 'package:ad_fluuter/featuers/login/logic/cubit/login_state.dart';
// import 'package:ad_fluuter/generated/l10n.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LoginBlocListener extends StatelessWidget {
//   const LoginBlocListener({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<LoginCubit, LoginState>(
//         listenWhen: (previous, current) =>
//             current is Loading || current is Error || current is Success,
//         listener: (BuildContext context, state) {
//           state.whenOrNull(
//             loading: () {
//               showDialog(
//                   context: context,
//                   builder: (context) => const Center(
//                         child: CircularProgressIndicator(
//                           color: ColorsManager.mainBlue,
//                         ),
//                       ));
//             },
//             success: (loginResponse) {
//               context.pop();
//               context.pushNamed(Routes.mainNavigationScreen);
//             },
//             error: (error) {
//               context.pop();
//               showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                         icon: const Icon(
//                           Icons.error,
//                           size: 32,
//                           color: Colors.red,
//                         ),
//                         content: Text(
//                           error,
//                           style:
//                               TextStyles(context).font15DarkBlueMedium(context),
//                         ),
//                         actions: [
//                           TextButton(
//                               onPressed: () {
//                                 context.pop();
//                               },
//                               child: Text(
//                                 S.current.Got_It,
//                                 style: TextStyles(context)
//                                     .font14BlueSemiBold(context),
//                               ))
//                         ],
//                       ));
//             },
//           );
//         },
//         child: const SizedBox.shrink());
//   }
// }
