import 'package:flutter/material.dart';

Widget drawerList(BuildContext context,
    {required Function() onSettingsClicked,
    required Function() onShareClicked}) {
  return ListView(
    padding: EdgeInsets.zero,
    children: [
      DrawerHeader(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        decoration: const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            // Aligns the text to the start (left)
            children: [
              Text(
                'Rick and Morty',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: GestureDetector(
          child: Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            child: const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ),
          onTap: () {
            onSettingsClicked();
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: GestureDetector(
          child: Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            child: const ListTile(
              leading: Icon(Icons.share),
              title: Text('Share App'),
            ),
          ),
          onTap: () {
            // TODO
          },
        ),
      ),
    ],
  );
}
