import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/features/characters/domain/entity/character_entity.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters/remote/remote_characters_bloc.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters/remote/remote_characters_state.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../bloc/characters/remote/remote_characters_event.dart';

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
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[_buildLargeAppBar(), _buildBody()],
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
              // TODO
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {
              // TODO
            },
          ),
        ]);
  }

  Widget _buildBody() {
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
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _buildListItem(context, state.characters![index]);
              },
              childCount: state.characters!.length,
            ),
          );
        }
        return const SliverFillRemaining(
          child: SizedBox(),
        );
      },
    );
  }

  Widget _buildListItem(BuildContext context, CharacterEntity entity) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: _buildCircularImage(context: context, url: entity.image!),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Text(
                  entity.species!,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: Text(
                  entity.name!,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Text(
                  "${entity.status!} - ${entity.location!.name!}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCircularImage({
    required BuildContext context,
    required String url,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.lightBlue, width: 1),
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          width: 50,
          height: 50,
          imageUrl: url,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
