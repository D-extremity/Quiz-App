part of 'question_upload_bloc.dart';

@immutable
sealed class QuestionUploadState {}

final class QuestionUploadInitial extends QuestionUploadState {}
final class NextQuestionPreviewState extends QuestionUploadState{}
final class PreviousQuestionPreviewState extends QuestionUploadState{}
final class ImageUploadState extends QuestionUploadState{}