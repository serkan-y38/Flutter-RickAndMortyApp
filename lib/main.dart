import 'package:flutter/material.dart';
import 'package:rickandmorty/core/di_container.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters/remote/remote_characters_bloc.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters/remote/remote_characters_event.dart';
import 'package:rickandmorty/features/characters/presentation/screen/characters_screen/characters_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteCharactersBloc>(
      create: (context) => singleton()..add(const GetCharacters()),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Rick and Morty',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const CharactersScreen()),
    );
  }
}
