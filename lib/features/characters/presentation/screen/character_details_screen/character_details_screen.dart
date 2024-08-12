import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/core/navigation.dart';
import 'package:rickandmorty/core/snack_bar.dart';
import 'package:rickandmorty/features/characters/domain/entity/character_entity.dart';
import 'package:rickandmorty/features/characters/presentation/screen/character_details_screen/widget/episode_list.dart';
import 'package:rickandmorty/features/characters/presentation/screen/character_details_screen/widget/info_card.dart';
import '../../../../../core/di_container.dart';
import '../../bloc/characters/local/local_characters_bloc.dart';
import '../../bloc/characters/local/local_characters_event.dart';
import '../../bloc/characters/local/local_characters_state.dart';

class CharacterDetailsScreen extends StatefulWidget {
  const CharacterDetailsScreen({super.key, required this.characterEntity});

  final CharacterEntity characterEntity;

  @override
  State<StatefulWidget> createState() => _CharacterDetailsScreen();
}

class _CharacterDetailsScreen extends State<CharacterDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocalCharactersBloc>(
      create: (context) =>
          singleton()..add(IsCharacterSaved(widget.characterEntity.id!)),
      child: BlocBuilder<LocalCharactersBloc, LocalCharactersState>(
        builder: (_, state) {
          bool isCharacterSaved = false;
          if (state is IsCharacterSavedResultSuccess && state.result != null) {
            isCharacterSaved = state.result!;
          }
          return _buildScaffold(isCharacterSaved);
        },
      ),
    );
  }

  Widget _buildScaffold(bool isCharacterSaved) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: _buildAppBar(context, isCharacterSaved))
          ];
        },
        body: Builder(builder: (BuildContext context) {
          return CustomScrollView(
            key: const PageStorageKey<String>(""),
            slivers: <Widget>[
              SliverOverlapInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
              SliverPadding(
                padding: const EdgeInsets.all(0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    if (index == 0) {
                      return buildInfoCard(widget.characterEntity);
                    } else if (index == 1) {
                      return buildEpisodesList(
                          context, widget.characterEntity.episode!,
                          onItemClicked: (episodeId) => Navigator.pushNamed(
                                context,
                                RouteNavigation.episodeScreen,
                                arguments: episodeId,
                              ));
                    }
                    return null;
                  }, childCount: 2),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, bool isCharacterSaved) {
    return SliverAppBar(
      expandedHeight: 350,
      floating: false,
      pinned: true,
      actions: <Widget>[
        Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                if (isCharacterSaved) {
                  context
                      .read<LocalCharactersBloc>()
                      .add(DeleteCharacter(widget.characterEntity));
                  showSnackBar(context, "Character deleted", "Undo",
                      onActionPressed: (_) {
                    // TODO
                  });
                } else {
                  context
                      .read<LocalCharactersBloc>()
                      .add(InsertCharacter(widget.characterEntity));
                  showSnackBar(context, "Character saved", "Undo",
                      onActionPressed: (_) {
                    // TODO
                  });
                }
                // Trigger a new state to rebuild the UI with the updated saved status
                context
                    .read<LocalCharactersBloc>()
                    .add(IsCharacterSaved(widget.characterEntity.id!));
              },
              icon: Icon(isCharacterSaved
                  ? Icons.bookmark_remove
                  : Icons.bookmark_add),
            );
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Text(widget.characterEntity.name!),
        background: CachedNetworkImage(
          imageUrl: widget.characterEntity.image!,
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
