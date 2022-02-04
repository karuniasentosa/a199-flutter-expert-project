import 'package:equatable/equatable.dart';

import 'genre.dart';
import 'season.dart';

class TvSeriesDetail extends Equatable {
  final int id;
  final List<Genre> genres;
  final List<Season>? seasons;
  final String posterPath;
  final String name;
  final num voteAverage;
  final int voteCount;
  final String status;
  final String firstAirDate;
  final String overview;
  final String originalLanguage;
  final String originalName;
  final int numberOfSeasons;
  final int numberOfEpisodes;

  TvSeriesDetail(
      {this.seasons,
      required this.id,
      required this.genres,
      required this.posterPath,
      required this.name,
      required this.voteAverage,
      required this.voteCount,
      required this.status,
      required this.firstAirDate,
      required this.overview,
      required this.originalLanguage,
      required this.originalName,
      required this.numberOfEpisodes,
      required this.numberOfSeasons});

  @override
  List<Object?> get props => [
        id,
        genres,
        seasons,
        name,
        voteAverage,
        voteCount,
        status,
        firstAirDate,
        overview,
        originalLanguage,
        originalName,
        posterPath,
      ];
}
