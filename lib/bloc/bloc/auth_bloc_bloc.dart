import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBlocBloc() : super(AuthBlocInitial()) {
    on<AuthBlocEvent>((event, emit) {
      emit(AuthBlocInitial());
    });

    on<AuthBlocEmailNotVerifiedEvent>(
        (event, emit) => emit(AuthBlocEmailNotVerifiedState()));

    on<AuthBlocEmailVerifiedEvent>(
        (event, emit) => AuthBlocEmailVerifiedState());
    on<AuthBlocEmptyFieldsEvent>(
      (event, emit) => AuthBlocEmptyFieldScreen,
    );

    on<AuthBlocInitialLoginEvent>(
      navigateToLoginPage,
    );

    on<AuthBlocAgeBelow15Event>(invalidAge);

    on<AuthBlocInitialSignUpEvent>(navigateToSignupPage);
  }

  FutureOr<void> navigateToLoginPage(
      AuthBlocInitialLoginEvent event, Emitter<AuthBlocState> emit) {
    emit(AuthBlocInitialLoginState());
  }

  FutureOr<void> navigateToSignupPage(
      AuthBlocInitialSignUpEvent event, Emitter<AuthBlocState> emit) {
    emit(AuthBlocInitialSignUpState());
  }

  FutureOr<void> invalidAge(
      AuthBlocAgeBelow15Event event, Emitter<AuthBlocState> emit) {
    emit(AuthBlocAgeBelow15State());
  }
  // Stream<void> invalidAge(
  //     AuthBlocAgeBelow15Event event, Emitter<AuthBlocState> emit)async* {
  //   yield(AuthBlocAgeBelow15State());
  // }
}
