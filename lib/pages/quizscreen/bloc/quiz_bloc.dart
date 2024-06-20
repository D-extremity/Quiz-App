import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizInitialState()) {
    on<QuizEvent>((event, emit) {
      emit(QuizInitialState());
    });

    on<NextQuizEvent>(
      (event, emit) => emit(NextQuizState()),
    );

    on<S1QuizEvent>(
      (event, emit) => emit(S1QuizState()),
    );

    on<QuizSubmittedEvent>(
      (event, emit) => emit(QuizSubmittedState()),
    );
  }
}
