part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocEvent {}
 class AuthBlocEmailVerifiedEvent extends AuthBlocEvent{}
 class AuthBlocEmailNotVerifiedEvent extends AuthBlocEvent{}
 class AuthBlocInitialLoginEvent extends AuthBlocEvent{}
 class AuthBlocInitialSignUpEvent extends AuthBlocEvent{}
 class AuthBlocAgeBelow15Event extends AuthBlocEvent{}
 class AuthBlocEmptyFieldsEvent extends AuthBlocEvent{}
