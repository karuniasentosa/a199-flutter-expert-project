import 'package:core/core.dart'
    show Failure; // show the failure so the code becomes mess
import 'package:dartz/dartz.dart';

import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
