part of 'movie_detail_cubit.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();
}

class MovieDetailInitial extends MovieDetailState {
  const MovieDetailInitial();

  @override
  List<Object?> get props => [];
}

class MovieDetailLoading extends MovieDetailState {
  const MovieDetailLoading();

  @override
  List<Object?> get props => [];
}

class MovieDetailResult extends MovieDetailState {
  final MovieDetail movieDetail;

  const MovieDetailResult(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class MovieDetailError extends MovieDetailState {
  final String errorMessage;

  const MovieDetailError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
