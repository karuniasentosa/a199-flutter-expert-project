part of 'movie_recommendations_cubit.dart';

@immutable
abstract class MovieRecommendationsState extends Equatable {
  const MovieRecommendationsState();
}

class MovieRecommendationsInitial extends MovieRecommendationsState {
  const MovieRecommendationsInitial(): super();

  @override
  List<Object?> get props => [];
}

class MovieRecommendationsLoading extends MovieRecommendationsState {
  const MovieRecommendationsLoading(): super();

  @override
  List<Object?> get props =>[];
}

class MovieRecommendationsResult extends MovieRecommendationsState {
  final List<Movie> movieRecommendations;

  const MovieRecommendationsResult(this.movieRecommendations);

  @override
  List<Object?> get props => [movieRecommendations];
}

class MovieRecommendationsError extends MovieRecommendationsState {
  final String errorMessage;

  const MovieRecommendationsError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
