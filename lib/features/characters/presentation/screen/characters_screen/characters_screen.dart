import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/core/navigation.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters/remote/remote_characters_bloc.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters/remote/remote_characters_state.dart';
import 'package:rickandmorty/features/characters/presentation/screen/characters_screen/widget/characters_list.dart';
import 'package:rickandmorty/features/characters/presentation/screen/characters_screen/widget/search_character_delegate.dart';
import '../../../../../core/di_container.dart';
import '../../bloc/characters/remote/remote_characters_event.dart';
import '../../bloc/search_character/remote_search_character_bloc.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.atEdge) {
      bool isBottom = _scrollController.position.pixels != 0;
      if (isBottom) {
        context.read<RemoteCharactersBloc>().add(const LoadMoreCharacters());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[_buildLargeAppBar(), _buildBody()],
        ),
      ),
    );
  }

  Widget _buildLargeAppBar() {
    return SliverAppBar.large(
        title: const Text("Characters"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            tooltip: 'Saved characters',
            onPressed: () {
              Navigator.pushNamed(
                  context, RouteNavigation.savedCharactersScreen);
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {
              // Navigator.pushNamed(context, RouteNavigation.searchCharacterScreen);
              showSearch(
                  context: context,
                  delegate: SearchCharacterDelegate(
                      singleton<RemoteSearchCharacterBloc>()));
            },
          ),
        ]);
  }

  Widget _buildBody() {
    context.read<RemoteCharactersBloc>().add(const LoadMoreCharacters());
    return BlocBuilder<RemoteCharactersBloc, RemoteCharactersState>(
      builder: (_, state) {
        if (state is RemoteCharactersLoading) {
          return const SliverFillRemaining(
            child: Center(child: CupertinoActivityIndicator()),
          );
        }
        if (state is RemoteCharactersError) {
          return const SliverFillRemaining(
            child: Center(child: Icon(Icons.error)),
          );
        }
        if (state is RemoteCharactersSuccess) {
          return CharactersListWidget(
              characters: state.characters,
              onListItemClicked: (entity) => Navigator.pushNamed(
                  context, RouteNavigation.characterDetailsScreen,
                  arguments: entity));
        }
        return const SliverFillRemaining(
          child: SizedBox(),
        );
      },
    );
  }
}
