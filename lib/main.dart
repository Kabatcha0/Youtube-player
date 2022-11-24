import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:youtubeapp/blocobserver.dart';
import 'package:youtubeapp/modules/youtubescreen.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: YoutubeScreen(),
    );
  }
}