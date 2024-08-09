import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/core/resource.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/episode/remote/remote_episode_event.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/episode/remote/remote_episode_state.dart';

import '../../../../domain/entity/episode_entity.dart';
import '../../../../domain/use_case/remote/get_episode_use_case.dart';

class RemoteEpisodeBloc extends Bloc<RemoteEpisodeEvent, RemoteEpisodeState> {
  final GetEpisodeUseCase _getEpisodeUseCase;

  RemoteEpisodeBloc(this._getEpisodeUseCase)
      : super(const RemoteEpisodeLoading()) {
    on<GetEpisode>(onGetEpisode);
  }

  void onGetEpisode(
      GetEpisode event, Emitter<RemoteEpisodeState> emitter) async {
    final dataState = await _getEpisodeUseCase(params: event.episodeId);
    if (dataState is Success<EpisodeEntity>) {
      emitter(RemoteEpisodeSuccess(dataState.data!));
    } else if (dataState is Error) {
      emitter(RemoteEpisodeError(dataState.dio!));
    } else if (dataState is Loading) {
      emitter(const RemoteEpisodeLoading());
    }
  }
}
