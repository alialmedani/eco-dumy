 
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AuthCubit extends Cubit<AuthState> {
//   final ApiService apiService;

//   AuthCubit(this.apiService) : super(AuthInitial());

//   Future<void> refreshToken() async {
//     emit(AuthLoading());
//     try {
//   final refreshToken = await SharedPrefHelper.getString(SharedPrefKeys.refreshToken1);
// if (refreshToken.isEmpty) {
//   emit(AuthFailure('لا يوجد refresh token'));
//   return;
// }

// print('refreshTokenwsqsq: $refreshToken');

//       final newTokens = await apiService.refreshToken({
//         'refreshToken': refreshToken,
//         'expiresInMins': 30,
//       });

//       await SharedPrefHelper.setData(SharedPrefKeys.userToken, newTokens.accessToken);
//       await SharedPrefHelper.setData(SharedPrefKeys.refreshToken1, newTokens.refreshToken);

//       emit(AuthRefreshSuccess(newTokens.accessToken));
//     } catch (e) {
//       emit(AuthFailure('فشل في تحديث التوكن: ${e.toString()}'));
//     }
//   }
// }
