import 'package:bloc/bloc.dart';
import 'package:core/common/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/usecases.dart' show GetMovieRecommendations;

part 'movie_recommendations_state.dart';

class MovieRecommendationsCubit extends Cubit<MovieRecommendationsState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieRecommendationsCubit(this.getMovieRecommendations)
      : super(const MovieRecommendationsInitial());

  Future call(int movieId) async {
    emit(const MovieRecommendationsLoading());
    final result = await getMovieRecommendations.execute(movieId);
    result.fold(_movieRecommendationsErrorCallback,
        _movieRecommendationsResultCallback);
  }

  void _movieRecommendationsResultCallback(List<Movie> result) {
    emit(MovieRecommendationsResult((result)));
  }

  void _movieRecommendationsErrorCallback(Failure failure) {
    emit(MovieRecommendationsError(failure.message));
  }
}
