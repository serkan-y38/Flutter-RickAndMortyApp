import 'package:rickandmorty/core/resource.dart';
import 'package:rickandmorty/features/presentation/bloc/characters/remote/remote_characters_event.dart';
import 'package:rickandmorty/features/presentation/bloc/characters/remote/remote_characters_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/features/domain/use_case/get_characters_use_case.dart';

class RemoteCharactersBloc
    extends Bloc<RemoteCharactersEvent, RemoteCharactersState> {
  final GetCharactersUseCase _getCharactersUseCase;

  RemoteCharactersBloc(this._getCharactersUseCase)
      : super(const RemoteCharactersLoading()) {
    on<GetCharacters>(onGetCharacters);
  }

  void onGetCharacters(
      GetCharacters event, Emitter<RemoteCharactersState> emitter) async {
    final dataState = await _getCharactersUseCase();
    if (dataState is Success && dataState.data!.isNotEmpty) {
      emitter(RemoteCharactersSuccess(dataState.data!));
    }
    if (dataState is Error) {
      emitter(RemoteCharactersError(dataState.dio!));
    }
    if (dataState is Loading) {
      emitter(const RemoteCharactersLoading());
    }
  }
}
