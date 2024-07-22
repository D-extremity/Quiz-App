part of 'video_bloc.dart';

@immutable
sealed class VideoEvent {}
 class VideoPlayEvent extends VideoEvent{}
 class VideoPauseEvent extends VideoEvent{}
