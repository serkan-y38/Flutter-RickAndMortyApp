import 'package:flutter/material.dart';
import 'package:rickandmorty/core/di/di_container.dart';
import 'package:rickandmorty/core/theme/theme.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters/remote/remote_characters_bloc.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters/remote/remote_characters_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/theme/theme_bloc.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/theme/theme_event.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/theme/theme_state.dart';
import 'core/navigation/navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<ThemeBloc>(
        create: (context) => singleton()..add(const GetTheme())),
    BlocProvider<RemoteCharactersBloc>(
      create: (context) => singleton()..add(const GetCharacters()),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          theme: ThemeUtils.getThemeData(state.theme, context),
          title: 'Rick and Morty',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouterClass.generateRoute,
          initialRoute: RouteNavigation.charactersScreen,
        );
      },
    );
  }
}
