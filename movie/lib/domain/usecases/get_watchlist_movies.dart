import 'package:dartz/dartz.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';
import 'package:core/core.dart' show Failure;

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
