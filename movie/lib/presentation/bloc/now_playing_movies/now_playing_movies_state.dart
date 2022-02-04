part of 'now_playing_movies_cubit.dart';

abstract class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();
}

class NowPlayingMoviesInitial extends NowPlayingMoviesState {
  @override
  List<Object> get props => [];
}

class NowPlayingMoviesLoading extends NowPlayingMoviesState {
  const NowPlayingMoviesLoading();

  @override
  List<Object?> get props => [];
}

class NowPlayingMoviesResult extends NowPlayingMoviesState {
  final List<Movie> movieList;

  const NowPlayingMoviesResult(this.movieList);

  @override
  List<Object?> get props => [movieList];
}

class NowPlayingMoviesError extends NowPlayingMoviesState {
  final String errorMessage;

  const NowPlayingMoviesError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
