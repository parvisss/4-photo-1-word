import 'package:find_the_word_from_pics/bloc/word_bloc.dart';
import 'package:find_the_word_from_pics/bloc/word_event.dart';
import 'package:find_the_word_from_pics/bloc/word_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Find The Word"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              BlocBuilder<WordBloc, WordState>(
                builder: (context, state) {
                  if (state is WordLoaded) {
                    return SizedBox(
                      height: 400,
                      width: 400,
                      child: GridView.builder(
                        itemCount: 4,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (ctx, index) {
                          return SizedBox(
                            key: const ValueKey("image"),
                            width: double.infinity,
                            height: 100,
                            child: Image.network(
                              state.targetWordPics![index],
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<WordBloc, WordState>(
                builder: (context, state) {
                  if (state is WordLoaded) {
                    final currentWord = state.currentWord;
                    return Flexible(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 60,
                          crossAxisSpacing: 6.0,
                          mainAxisSpacing: 6.0,
                        ),
                        itemCount: state.targetWord.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: double.infinity,
                            child: Container(
                              transformAlignment: Alignment.center,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                index < currentWord.length
                                    ? currentWord[index]
                                    : "",
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),

              // letters
              BlocBuilder<WordBloc, WordState>(
                builder: (context, state) {
                  if (state is WordLoaded) {
                    final randomLetters = state.randomLetters;
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 50,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemCount: randomLetters.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        String letter = randomLetters[index];
                        return GestureDetector(
                          onTap: () {
                            context.read<WordBloc>().add(AddLetter(letter));
                          },
                          child: Center(
                            key: const ValueKey("letters"),
                            child: Container(
                              transformAlignment: Alignment.center,
                              alignment: Alignment.center,
                              color: Colors.blue,
                              child: Text(
                                letter,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FilledButton(
                    key: const ValueKey("Check Word"),
                    onPressed: () {
                      context.read<WordBloc>().add(CheckWord());
                    },
                    child: const Text("Check Word"),
                  ),
                  IconButton(
                      key: const ValueKey("delete"),
                      onPressed: () {
                        context.read<WordBloc>().add(DeleteLetter());
                      },
                      icon: const Icon(Icons.backspace))
                ],
              ),
              BlocListener<WordBloc, WordState>(
                listener: (context, state) {
                  if (state is WordCorrect) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Congratulations! You found the word!"),
                      backgroundColor: Colors.green,
                    ));
                  } else if (state is WordIncorrect) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Try Again! Word not found."),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
