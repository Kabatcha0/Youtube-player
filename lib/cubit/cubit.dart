import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtubeapp/cubit/states.dart';

class YoutubeCubit extends Cubit<YoutubeStates> {
  YoutubeCubit() : super(YoutubeInitialState());
  static YoutubeCubit get(context) => BlocProvider.of(context);
  YoutubePlayer? player;
  YoutubePlayerController? controller;
  String url = "https://www.youtube.com/watch?v=wIqk4ZqVwxs";
  late String id;
  void init() {
    id = YoutubePlayer.convertUrlToId(url)!;
    controller = YoutubePlayerController(
        initialVideoId: id, flags: const YoutubePlayerFlags(autoPlay: false));
    player = YoutubePlayer(
      controller: controller!,
      aspectRatio: 1.5,
    );
    emit(YoutubeinitState());
  }

  String title = "";
  String auth = "";
  void titleMethod() {
    controller!.metadata.title;
    emit(YoutubeTitleState());
  }

  void authMethod() {
    controller!.metadata.author;
    emit(YoutubePauseState());
  }

  bool isPlaying = false;
  void play() {
    controller!.play();
    isPlaying = !isPlaying;
    emit(YoutubePlayState());
  }

  void pause() {
    controller!.pause();
    isPlaying = !isPlaying;
    emit(YoutubePauseState());
  }

  bool isMute = false;
  void mute() {
    controller!.mute();
    isMute = !isMute;
    emit(YoutubeMuteState());
  }

  void unMute() {
    controller!.unMute();
    isMute = !isMute;
    emit(YoutubeUnMuteState());
  }

  void seekPlus() {
    controller!
        .seekTo(controller!.value.position + const Duration(seconds: 10));
    emit(YoutubeSeekPlusState());
  }

  void seekMinus() {
    if (controller!.value.position <= const Duration(seconds: 10)) {
      controller!.seekTo(const Duration(seconds: 0));
    } else {
      controller!
          .seekTo(controller!.value.position - const Duration(seconds: 10));
    }
    emit(YoutubeSeekMinusState());
  }
}
