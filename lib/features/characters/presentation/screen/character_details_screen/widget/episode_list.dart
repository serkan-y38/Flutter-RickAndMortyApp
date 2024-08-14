import 'package:flutter/material.dart';

Widget buildEpisodesList(BuildContext context, List<String> episodes,
    {required Function(String) onItemClicked}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text("Episodes"),
          ),
        ),
        GridView.builder(
          padding: const EdgeInsets.only(top: 10),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8,
          ),
          itemCount: episodes.length,
          itemBuilder: (BuildContext context, int index) {
            var episodeId = episodes[index].split('/').last;
            return GestureDetector(
              onTap: () {
                onItemClicked(episodeId);
              },
              child: Card(child: Center(child: Text(episodeId))),
            );
          },
        ),
      ],
    ),
  );
}
