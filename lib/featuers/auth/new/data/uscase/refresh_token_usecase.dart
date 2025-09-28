import 'package:eco_dumy/core/params/base_params.dart';
import 'package:eco_dumy/core/results/result.dart';
import 'package:eco_dumy/core/usecase/usecase.dart';
import 'package:eco_dumy/featuers/auth/new/data/model/login_model.dart';
import 'package:eco_dumy/featuers/auth/new/data/repo/auth_repository.dart';

class RefreshTokenParams extends BaseParams {
  String refreshToken; 
  int expiresInMins;

  RefreshTokenParams({required this.expiresInMins, required this.refreshToken});
  toJson() {
    return {"expiresInMins": expiresInMins, "refreshToken": refreshToken};
  }
}

class RefreshTokenUsecase extends UseCase<LoginModel, RefreshTokenParams> {
  late final AuthRepository repository;
  RefreshTokenUsecase(this.repository);

  @override
  Future<Result<LoginModel>> call({required RefreshTokenParams params}) {
    return repository.refreshTokenRequest(params: params);
  }
}
