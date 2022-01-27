import 'package:dartz/dartz.dart' show Either;
import 'package:core/core.dart' show /*your*/ Failure;
import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';

class SaveWatchlist {
  final MovieRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
