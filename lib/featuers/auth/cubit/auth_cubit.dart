import 'package:bloc/bloc.dart';
import 'package:eco_dumy/featuers/auth/data/repo/auth_repository.dart';
import 'package:eco_dumy/featuers/auth/data/uscase/login_usecase.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
 
import 'dart:async';
import '../../../core/results/result.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoginButtonEnabled = false;
  bool isVerificationButtonEnabled = false;
  bool canResend = false;
  int remainingSeconds = 60;
  Timer? _timer;

  LoginParams loginParams = LoginParams(
    username: '1',
    password: '1',
    expiresInMins: 30 
   
  );
  // RegisterParams registerParams = RegisterParams(
  //   userName: "",
  //   name: "",
  //   phoneNumber: "",
  //   roles: [],
  //   officeId: "",
  //   floorId: "",
  //   password: "",
  // );

  Future<Result> login() async {
    return await LoginUsecase(AuthRepository()).call(params: loginParams);
  }

  // Future<Result> register() async {
  //   return await RegisterUseCase(AuthRepository()).call(params: registerParams);
  // }

  void toggleLoginButton(String value) {
    String cleaned = value.trim();

    if (cleaned.startsWith('0')) {
      cleaned = cleaned.substring(1);
    }
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
