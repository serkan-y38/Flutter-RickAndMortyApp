import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/core/navigation/navigation.dart';
import '../../../../domain/entity/character_entity.dart';
import '../../../bloc/search_character/remote_search_character_event.dart';
import '../../../bloc/search_character/remote_search_character_state.dart';
import 'list_item.dart';

class SearchCharacterDelegate extends SearchDelegate<CharacterEntity> {
  final Bloc<RemoteSearchCharacterEvent, RemoteSearchCharacterState> searchBloc;
  final _controller = ScrollController();

  String currentQuery = "";

  SearchCharacterDelegate(this.searchBloc) {
    _controller.addListener(() {
      if (_controller.position.atEdge && _controller.position.pixels == 0) {
        searchBloc.add(LoadMoreSearchCharacter(currentQuery));
      }
    });
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        systemOverlayStyle: colorScheme.brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        backgroundColor: colorScheme.surface,
        iconTheme:
            theme.primaryIconTheme.copyWith(color: colorScheme.onSurface),
        titleTextStyle: theme.textTheme.titleLarge,
        toolbarTextStyle: theme.textTheme.bodyMedium,
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
            border: InputBorder.none,
          ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query.isEmpty
            ? close(context, const CharacterEntity())
            : query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, const CharacterEntity()),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return (query.isNotEmpty) ? _buildResultList(query) : const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return (query.isNotEmpty) ? _buildResultList(query) : const SizedBox();
  }

  Widget _buildResultList(String query) {
    currentQuery = query;
    searchBloc.add(SearchCharacters(query));
    searchBloc.add(LoadMoreSearchCharacter(currentQuery));
    return BlocBuilder(
      bloc: searchBloc,
      builder: (context, state) {
        if (state is RemoteSearchCharacterLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is RemoteSearchCharacterError) {
          return const Center(child: Icon(Icons.error));
        }
        if (state is RemoteSearchCharacterSuccess) {
          return ListView.builder(
              controller: _controller,
              itemCount: state.characters!.length,
              itemBuilder: (context, index) {
                return CharacterListItemWidget(
                    onListItemClicked: (entity) => Navigator.pushNamed(
                        context, RouteNavigation.characterDetailsScreen,
                        arguments: entity),
                    characterEntity: state.characters![index]);
              });
        }
        return const SizedBox();
      },
    );
  }
}
