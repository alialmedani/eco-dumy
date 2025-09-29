     
 
import 'package:eco_dumy/core/params/base_params.dart';
import 'package:eco_dumy/core/results/result.dart';
import 'package:eco_dumy/core/usecase/usecase.dart';
import 'package:eco_dumy/featuers/auth/data/model/login_model.dart';
import 'package:eco_dumy/featuers/auth/data/repo/auth_repository.dart';

 
  
class LoginParams extends BaseParams {
  String username;
  String password;
  int? expiresInMins; // اختياري

  LoginParams({
    required this.username,
    required this.password,
    this.expiresInMins,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username.trim(),
      "password": password.trim(),
        "expiresInMins": expiresInMins,
    };
  }
}


class LoginUsecase extends UseCase<LoginModel, LoginParams> {
  late final AuthRepository repository;
  LoginUsecase(this.repository);

  @override
  Future<Result<LoginModel>> call({required LoginParams params}) {
    return repository.loginRequest(params: params);
  }
}
