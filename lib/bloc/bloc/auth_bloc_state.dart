part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocState {}

final class AuthBlocInitial extends AuthBlocState {}
class AuthBlocEmailVerifiedState extends AuthBlocState{}
 class AuthBlocEmailNotVerifiedState extends AuthBlocState{}
 class AuthBlocInitialLoginState extends AuthBlocState{}
 class AuthBlocInitialSignUpState extends AuthBlocState{}
 class AuthBlocAgeBelow15State extends AuthBlocState{}
 class AuthBlocEmptyFieldScreen extends AuthBlocState{}