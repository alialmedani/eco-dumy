import 'dart:convert';

import 'package:eco_dumy/core/constant/end_points/api_url.dart';
import 'package:eco_dumy/core/data_source/remote_data_source.dart';
import 'package:eco_dumy/core/http/http_method.dart';
import 'package:eco_dumy/core/repository/core_repository.dart';
import 'package:eco_dumy/core/results/result.dart';
import 'package:eco_dumy/featuers/auth/new/data/model/login_model.dart';
import 'package:eco_dumy/featuers/auth/new/data/uscase/login_usecase.dart';
import 'package:eco_dumy/featuers/auth/new/data/uscase/refresh_token_usecase.dart';

 

class AuthRepository extends CoreRepository {
  Future<Result<LoginModel>> loginRequest({required LoginParams params}) async {
    final result = await RemoteDataSource.request<LoginModel>(
      contentType: 'application/json',
      withAuthentication: false,
      data: params.toJson(),
      url: loginUrl,
      method: HttpMethod.POST,
      converter: (json) {
        return LoginModel.fromJson(json);
      },
    );
    return call(result: result);
  }

  // Future<Result<RegisterModel>> registerRequest({
  //   required RegisterParams params,
  // }) async {
  //   final result = await RemoteDataSource.request<RegisterModel>(
  //     withAuthentication: false,
  //     data: params.toJson(),
  //     url: registerUrl,
  //     method: HttpMethod.POST,
  //     converter: (json) {
  //       return RegisterModel.fromJson(json);
  //     },
  //   );
  //   return call(result: result);
  // }

  // Future<Result<CurrentCustomerModel>> currentUserRequest({
  //   required CurrentCustomerParams params,
  // }) async {
  //   final result = await RemoteDataSource.request<CurrentCustomerModel>(
  //     withAuthentication: true,
  //     url: currentCustomerUrl,
  //     method: HttpMethod.GET,
  //     converter: (json) {
  //       return CurrentCustomerModel.fromJson(json);
  //     },
  //   );

  //   return call(result: result);
  // }

  // Future<Result<FormModel>> currentUserFormRequest({
  //   required CurrentCustomerFormParams params,
  // }) async {
  //   final result = await RemoteDataSource.request<FormModel>(
  //     withAuthentication: true,
  //     url: currentCustomerFormUrl,
  //     method: HttpMethod.GET,
  //     converter: (json) {
  //       return FormModel.fromJson(json);
  //     },
  //   );

  //   return call(result: result);
  // }

  Future<Result<LoginModel>> refreshTokenRequest({
    required RefreshTokenParams params,
  }) async {
    final result = await RemoteDataSource.request<LoginModel>(
      contentType: 'application/json',
      withAuthentication: false,
      data: params.toJson(),
      url: loginUrl,
      method: HttpMethod.POST,
      converter: (json) {
        return LoginModel.fromJson(json);
      },
    );

    return call(result: result);
  }
 

  // Future<Result<String>> setDeviceIdRequest({
  //   required SetDeviceIdParams params,
  // }) async {
  //   final result = await RemoteDataSource.noModelRequest(
  //     withAuthentication: true,
  //     data: params.toJson(),
  //     url: setDeviceIdUrl,
  //     method: HttpMethod.POST,
  //   );

  //   return call(result: result);
  // }

  // Future<Result<List<TenantModel>>> getAllTenenatRequest({
  //   required GetAllTenantParams params,
  // }) async {
  //   final result = await RemoteDataSource.request<List<TenantModel>>(
  //     withAuthentication: false,
  //     url: getTenantUrl,
  //     method: HttpMethod.GET,
  //     converter2: (json) {
  //       return List<TenantModel>.from(json.map((x) => TenantModel.fromJson(x)));
  //     },
  //   );
  //   return call(result: result);
  // }
}
