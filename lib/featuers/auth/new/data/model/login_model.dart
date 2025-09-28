// features/auth/data/model/login_model.dart
class LoginModel {
  String? accessToken;
  String? refreshToken;

  // (اختياري) لو حابب تحفظ معلومات المستخدم الراجعة من الـ API:
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? gender;
  String? image;

  LoginModel({
    this.accessToken,
    this.refreshToken,
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.image,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    // مفاتيح dummyjson
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];

    // (اختياري) حقول المستخدم:
    id = json['id'];
    username = json['username'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    image = json['image'];
  }
}
