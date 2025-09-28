class LoginModel {
  String? accessToken;
  String? refreshToken;
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

  // ⬇️ Factory من Map
  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    accessToken: json['accessToken'] as String?,
    refreshToken: json['refreshToken'] as String?,
    id: json['id'] as int?,
    username: json['username'] as String?,
    email: json['email'] as String?,
    firstName: json['firstName'] as String?,
    lastName: json['lastName'] as String?,
    gender: json['gender'] as String?,
    image: json['image'] as String?,
  );

  // ⬇️ تحويل إلى Map
  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'id': id,
    'username': username,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'gender': gender,
    'image': image,
  };
}
