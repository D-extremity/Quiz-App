part of 'video_bloc.dart';

@immutable
sealed class VideoState {}

final class VideoInitial extends VideoState {}
class VideoPlayState extends VideoState {}
class VideoPauseState extends VideoState {}
