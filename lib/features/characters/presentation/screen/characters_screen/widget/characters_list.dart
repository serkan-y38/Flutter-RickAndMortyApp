import 'package:flutter/material.dart';
import 'package:rickandmorty/features/characters/domain/entity/character_entity.dart';
import 'package:flutter/cupertino.dart';

import 'list_item.dart';

class CharactersListWidget extends StatelessWidget {
  final List<CharacterEntity>? characters;
  final void Function(CharacterEntity entity)? onListItemClicked;

  const CharactersListWidget(
      {super.key, this.characters, this.onListItemClicked});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return CharacterListItemWidget(
              characterEntity: characters![index],
              onListItemClicked: onListItemClicked);
        },
        childCount: characters!.length,
      ),
    );
  }
}
