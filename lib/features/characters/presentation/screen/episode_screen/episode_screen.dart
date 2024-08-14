import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/features/characters/domain/entity/character_entity.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters_with_ids/remote/remote_characters_with_ids_bloc.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters_with_ids/remote/remote_characters_with_ids_event.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters_with_ids/remote/remote_characters_with_ids_state.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/episode/remote/remote_episode_bloc.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/episode/remote/remote_episode_event.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/episode/remote/remote_episode_state.dart';
import '../../../../../core/di/di_container.dart';
import '../../../../../core/navigation/navigation.dart';

class EpisodeScreen extends StatelessWidget {
  const EpisodeScreen({super.key, this.episodeId});

  final String? episodeId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteEpisodeBloc>(
      create: (context) => singleton()..add(GetEpisode(episodeId: episodeId)),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: BlocBuilder<RemoteEpisodeBloc, RemoteEpisodeState>(
        builder: (context, state) {
          if (state is RemoteEpisodeSuccess && state.episode != null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(state.episode!.name!),
                Text(
                  "Episode - ${state.episode!.episode}",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            );
          } else {
            return const Text("");
          }
        },
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<RemoteEpisodeBloc, RemoteEpisodeState>(
      builder: (_, episodeState) {
        if (episodeState is RemoteEpisodeLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (episodeState is RemoteEpisodeError) {
          return const Center(child: Icon(Icons.error));
        }
        if (episodeState is RemoteEpisodeSuccess) {
          return BlocProvider<RemoteCharactersWithIdsBloc>(
              create: (context) => singleton()
                ..add(GetCharactersWithIds(
                    idList: episodeState.episode!.characters!.map((character) {
                  return character
                      .split('/')
                      .last; // Assuming character has an 'id' property
                }).join(","))),
              child: BlocBuilder<RemoteCharactersWithIdsBloc,
                  RemoteCharactersWithIdsState>(
                builder: (_, charactersState) {
                  if (charactersState is RemoteCharactersWithIdsLoading) {
                    return const Center(child: CupertinoActivityIndicator());
                  }
                  if (charactersState is RemoteCharactersWithIdsError) {
                    return const Center(child: Icon(Icons.error));
                  }
                  if (charactersState is RemoteCharactersWithIdsSuccess) {
                    return _buildList(charactersState.characters);
                  }
                  return const SizedBox();
                },
              ));
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildList(List<CharacterEntity>? characters) {
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8),
        itemCount: characters!.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildListItem(characters[index],
              onListItemClicked: (entity) => {
                    Navigator.pushNamed(
                        context, RouteNavigation.characterDetailsScreen,
                        arguments: entity)
                  });
        });
  }

  Widget _buildListItem(CharacterEntity characterEntity,
      {required void Function(CharacterEntity entity)? onListItemClicked}) {
    return GestureDetector(
      onTap: () {
        if (onListItemClicked != null) onListItemClicked(characterEntity);
      },
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: CachedNetworkImage(
          imageUrl: characterEntity.image!,
          imageBuilder: (context, imageProvider) => Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(
              value: downloadProgress.progress,
            ),
          ),
          errorWidget: (context, url, error) =>
              const Center(child: Icon(Icons.error)),
        ),
      ),
    );
  }
}
