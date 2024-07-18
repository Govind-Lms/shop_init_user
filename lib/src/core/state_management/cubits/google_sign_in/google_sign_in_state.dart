part of 'google_sign_in_cubit.dart';

sealed class GoogleSignInState {
  const GoogleSignInState();
}

final class AuthInitial extends GoogleSignInState {}
final class AuthLoading extends GoogleSignInState {}
final class AuthSuccess extends GoogleSignInState {
  final User user;
  const AuthSuccess(this.user);
}

final class AuthFailure extends GoogleSignInState {
  final String failureMessage;
  const AuthFailure(this.failureMessage);
}

final class AuthLogOut extends GoogleSignInState {
  final String message;
  const AuthLogOut(this.message);
}
