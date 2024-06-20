part of 'quiz_bloc.dart';

@immutable
sealed class QuizEvent {}

class NextQuizEvent extends QuizEvent{}

class S1QuizEvent extends QuizEvent{}
class QuizSubmittedEvent extends QuizEvent{}
