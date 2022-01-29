import 'package:bloc/bloc.dart';
import 'package:core/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/usecases.dart' show GetMovieDetail;

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  MovieDetailCubit(this.getMovieDetail) : super(const MovieDetailInitial());

  /// I have no idea what to name...
  Future call(int movieId) async {
    emit(const MovieDetailLoading());
    final result = await getMovieDetail.execute(movieId);
    result.fold(_movieDetailErrorCallback, _movieDetailResultCallback);
  }

  void _movieDetailResultCallback(MovieDetail result) {
    emit(MovieDetailResult(result));
  }

  void _movieDetailErrorCallback(Failure error) {
    emit(MovieDetailError(error.message));
  }
}
