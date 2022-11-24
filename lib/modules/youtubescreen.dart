import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtubeapp/cubit/cubit.dart';
import 'package:youtubeapp/cubit/states.dart';

class YoutubeScreen extends StatelessWidget {
  const YoutubeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => YoutubeCubit()
        ..init()
        ..titleMethod()
        ..authMethod(),
      child: BlocConsumer<YoutubeCubit, YoutubeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = YoutubeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.black,
              title: const Text(
                "Youtube Player",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: cubit.player,
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    cubit.controller!.metadata.title,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  cubit.controller!.metadata.author,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        cubit.seekMinus();
                      },
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                      iconSize: 35,
                    ),
                    IconButton(
                      onPressed: () {
                        if (cubit.controller!.value.isPlaying) {
                          cubit.pause();
                        } else {
                          cubit.play();
                        }
                      },
                      icon: cubit.isPlaying == true
                          ? const Icon(
                              Icons.pause,
                            )
                          : const Icon(
                              Icons.play_arrow,
                            ),
                      iconSize: 35,
                    ),
                    IconButton(
                      onPressed: () {
                        cubit.seekPlus();
                      },
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                      iconSize: 35,
                    ),
                  ],
                )
              ],
            )),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {
                if (cubit.isMute == true) {
                  cubit.unMute();
                } else {
                  cubit.mute();
                }
              },
              child: cubit.isMute == true
                  ? const Icon(Icons.volume_off)
                  : const Icon(Icons.volume_up),
            ),
          );
        },
      ),
    );
  }
}
