import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/usecases.dart' show GetPopularMovies;

part 'popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  final GetPopularMovies getPopularMovies;
  PopularMoviesCubit(this.getPopularMovies)
      : super(PopularMoviesInitial());

  Future call() async {
    emit(const PopularMoviesLoading());
    final result = await getPopularMovies.execute();
    result.fold(
        (failure) => emit(PopularMoviesError(failure.message)),
        (movies) => emit(PopularMoviesResult(movies))
    );
  }
}
