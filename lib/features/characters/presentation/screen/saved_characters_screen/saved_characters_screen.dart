import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/core/navigation/navigation.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters/local/local_characters_bloc.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters/local/local_characters_event.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters/local/local_characters_state.dart';
import 'package:rickandmorty/features/characters/presentation/screen/characters_screen/widget/list_item.dart';
import '../../../../../core/di/di_container.dart';

class SavedCharactersScreen extends StatelessWidget {
  const SavedCharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocalCharactersBloc>(
      create: (context) => singleton()..add(const GetSavedCharacters()),
      child: BlocBuilder<LocalCharactersBloc, LocalCharactersState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Saved Characters"),
            ),
            body: _buildBody(context),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    context.read<LocalCharactersBloc>().add(const GetSavedCharacters());
    return BlocBuilder<LocalCharactersBloc, LocalCharactersState>(
      builder: (_, state) {
        if (state is LocalCharactersLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is LocalCharactersError) {
          return const Center(child: Icon(Icons.error));
        }
        if (state is LocalCharactersSuccess) {
          return ListView.builder(
            itemCount: state.characters!.length,
            itemBuilder: (context, index) {
              return CharacterListItemWidget(
                  characterEntity: state.characters![index],
                  onListItemClicked: (entity) => Navigator.pushNamed(
                        context,
                        RouteNavigation.characterDetailsScreen,
                        arguments: entity,
                      ));
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
