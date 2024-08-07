import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:rickandmorty/features/characters/domain/entity/episode_entity.dart';

abstract class RemoteEpisodeState extends Equatable {
  final EpisodeEntity? episode;
  final DioException? dioException;

  const RemoteEpisodeState({this.episode, this.dioException});

  @override
  List<Object?> get props => [episode, dioException];
}

class RemoteEpisodeLoading extends RemoteEpisodeState {
  const RemoteEpisodeLoading();
}

class RemoteEpisodeSuccess extends RemoteEpisodeState {
  const RemoteEpisodeSuccess(EpisodeEntity e) : super(episode: e);
}

class RemoteEpisodeError extends RemoteEpisodeState {
  const RemoteEpisodeError(DioException e) : super(dioException: e);
}
