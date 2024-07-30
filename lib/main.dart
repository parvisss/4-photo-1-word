// main.dart
import 'package:find_the_word_from_pics/bloc/word_bloc.dart';
import 'package:find_the_word_from_pics/bloc/word_event.dart';
import 'package:find_the_word_from_pics/ui/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Find The Word Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => WordBloc()..add(GenerateTargetWord()),
        child: const MainScreen(),
      ),
    );
  }
}
