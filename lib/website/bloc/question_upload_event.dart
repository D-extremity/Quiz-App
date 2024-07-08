part of 'question_upload_bloc.dart';

@immutable
sealed class QuestionUploadEvent {}

final class NextQuestionPreviewEvent extends QuestionUploadEvent{}
final class PreviousQuestionPreviewEvent extends QuestionUploadEvent{}
final class ImageUploadEvent extends QuestionUploadEvent{}
