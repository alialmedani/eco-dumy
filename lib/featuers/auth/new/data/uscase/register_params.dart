 

// import 'package:eco_dumy/core/params/base_params.dart';

// class RegisterParams extends BaseParams {
//   String userName;
//   String name;
//   String phoneNumber;
//   String officeId;
//   String floorId;
//   String password;
//   List<String> roles;

//   RegisterParams({
//     required this.userName,
//     required this.name,
//     required this.phoneNumber,
//     required this.roles,
//     required this.officeId,
//     required this.floorId,
//     required this.password,
//   });

//   toJson() {
//     return {
//       "userName": userName,
//       "name": name,
//       "roles": roles,

//       "phoneNumber": phoneNumber,
//       "officeId": officeId,
//       "floorId": floorId,
//       "password": password,
//     };
//   }
// }

// class RegisterUseCase extends UseCase<RegisterModel, RegisterParams> {
//   late final AuthRepository repository;
//   RegisterUseCase(this.repository);

//   @override
//   Future<Result<RegisterModel>> call({required RegisterParams params}) {
//     return repository.registerRequest(params: params);
//   }
// }
