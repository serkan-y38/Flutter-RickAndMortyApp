import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entity/character_entity.dart';

class CharacterListItemWidget extends StatelessWidget {
  final CharacterEntity? characterEntity;
  final void Function(CharacterEntity entity)? onListItemClicked;

  const CharacterListItemWidget(
      {super.key, this.characterEntity, this.onListItemClicked});

  @override
  Widget build(BuildContext context) {
    return _buildListItem(context, characterEntity!);
  }

  Widget _buildListItem(BuildContext context, CharacterEntity entity) {
    return GestureDetector(
      onTap: () {
        if (onListItemClicked != null) onListItemClicked!(entity);
      },
      child: Row(
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
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
      ),
    );
  }

  Widget _buildCircularImage({
    required BuildContext context,
    required String url,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 1),
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
