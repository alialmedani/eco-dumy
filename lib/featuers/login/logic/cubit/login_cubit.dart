 
// import 'package:ad_fluuter/core/helbers/constants.dart';
// import 'package:ad_fluuter/core/helbers/shared_pref_helper.dart';
// import 'package:ad_fluuter/core/networking/dio_factory.dart';
// import 'package:ad_fluuter/featuers/login/data/models/login_request_body.dart';
// import 'package:ad_fluuter/featuers/login/data/models/login_response.dart';
// import 'package:ad_fluuter/featuers/login/data/reos/login_repo.dart';
// import 'package:ad_fluuter/featuers/login/logic/cubit/login_state.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LoginCubit extends Cubit<LoginState> {
//   final LoginRepo _loginRepo;
//   LoginCubit(this._loginRepo) : super(const LoginState.initial());

//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   void emitLogInStates() async {
//     emit(const LoginState.loading());

//     final response = await _loginRepo.login(
//       LoginRequestBody(
//         username: emailController.text,
//         password: passwordController.text,
//       ),
//     );

//     response.when(
//       success: (loginResponse) async {
//         await saveUserDetails(loginResponse);
//         emit(LoginState.success(loginResponse));
//       },
//       failure: (error) {
//         emit(LoginState.error(error: error.apiErrorModel.message ?? ''));
//       },
//     );
//   }

//   Future<void> saveUserDetails(LoginResponse loginResponse) async {
//     // حفظ التوكنات
//     await SharedPrefHelper.setData(SharedPrefKeys.userToken, loginResponse.accessToken);
//     await SharedPrefHelper.setData(SharedPrefKeys.refreshToken1, loginResponse.refreshToken);

//     // حفظ البيانات الشخصية
//     await SharedPrefHelper.setData(SharedPrefKeys.firstName, loginResponse.firstName);
//     await SharedPrefHelper.setData(SharedPrefKeys.id, loginResponse.id);
//     await SharedPrefHelper.setData(SharedPrefKeys.lastName, loginResponse.lastName);
//     await SharedPrefHelper.setData(SharedPrefKeys.userName, loginResponse.username);
//     await SharedPrefHelper.setData(SharedPrefKeys.email, loginResponse.email);
//     await SharedPrefHelper.setData(SharedPrefKeys.image, loginResponse.image);

//     // تحديث الهيدر
//     DioFactory.setTokenIntoHeaderAfterLogin(loginResponse.accessToken);
//   }

 
// }
