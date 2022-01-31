import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/usecases.dart' show SearchMovies;

part 'search_movies_state.dart';

class SearchMoviesCubit extends Cubit<SearchMoviesState> {
  final SearchMovies searchMovies;
  SearchMoviesCubit(this.searchMovies) : super(SearchMoviesInitial());

  Future call(String query) async {
    emit(const SearchMoviesLoading());

    final result = await searchMovies.execute(query);

    result.fold(
            (failure) => emit(SearchMoviesError(failure.message)),
            (movies) => emit(SearchMoviesResult(movies))
    );
  }
}
