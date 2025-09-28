abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthRefreshSuccess extends AuthState {
  final String accessToken;
  AuthRefreshSuccess(this.accessToken);
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}
