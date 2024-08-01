import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/features/presentation/bloc/character/remote/remote_characters_bloc.dart';
import 'package:rickandmorty/features/presentation/bloc/character/remote/remote_characters_state.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text(
        "List",
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteCharactersBloc, RemoteCharactersState>(
      builder: (_, state) {
        if (state is RemoteCharactersLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is RemoteCharactersError) {
          return const Center(child: Icon(Icons.error));
        }
        if (state is RemoteCharactersSuccess) {
          return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(title: Text(index.toString()));
              },
              itemCount: state.characters!.length);
        }
        return const SizedBox();
      },
    );
  }
}
