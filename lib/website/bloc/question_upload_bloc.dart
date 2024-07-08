import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'question_upload_event.dart';
part 'question_upload_state.dart';

class QuestionUploadBloc
    extends Bloc<QuestionUploadEvent, QuestionUploadState> {
  QuestionUploadBloc() : super(QuestionUploadInitial()) {
    on<QuestionUploadEvent>((event, emit) {});
    on<NextQuestionPreviewEvent>((event, emit) {
      emit(NextQuestionPreviewState());
    });
    on<PreviousQuestionPreviewEvent>((event, emit) {
      emit(PreviousQuestionPreviewState());
    });
     on<ImageUploadEvent>((event, emit) {
      emit(ImageUploadState());
    });
  }
}
