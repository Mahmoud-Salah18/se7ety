class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final String? role;

  AuthSuccessState({this.role});
}

class AuthErrorState extends AuthState {
  final String message;
  AuthErrorState({required this.message});
}
