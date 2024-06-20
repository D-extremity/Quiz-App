part of 'quiz_bloc.dart';

@immutable
sealed class QuizState {}

final class QuizInitialState extends QuizState {}

final class NextQuizState extends QuizState {}

final class S1QuizState extends QuizState {}
final class QuizSubmittedState extends QuizState {}
