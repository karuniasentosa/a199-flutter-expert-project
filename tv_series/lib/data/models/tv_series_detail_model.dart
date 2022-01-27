import 'package:ditonton/data/models/genre_model.dart';
import 'season_model.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetailModel extends Equatable {
  final int id;
  final List<GenreModel> genres;
  final List<SeasonModel>? seasons;
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

  TvSeriesDetailModel(
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
      required this.numberOfSeasons,
      required this.numberOfEpisodes});

  factory TvSeriesDetailModel.fromJsonMap(Map<String, dynamic> map) {
    final int id = map['id'];
    final List<GenreModel> genres = (map['genres'] as List).map((e) => GenreModel.fromJson(e)).toList();
    List<SeasonModel>? seasons;
    if (map['seasons'] != null) {
      seasons = (map['seasons'] as List)
          .map((e) => SeasonModel.fromJsonMap(e))
          .toList();
    }
    final String posterPath = map['poster_path'];
    final String name = map['name'];
    final num voteAverage = map['vote_average'];
    final int voteCount = map['vote_count'];
    final String status = map['status'];
    final String firstAirDate = map['first_air_date'];
    final String overview = map['overview'];
    final String originalLanguage = map['original_language'];
    final String originalName = map['original_name'];
    final int numberOfEpisodes = map['number_of_episodes'];
    final int numberOfSeasons = map['number_of_seasons'];

    return TvSeriesDetailModel(
        id: id,
        genres: genres,
        seasons: seasons,
        name: name,
        voteAverage: voteAverage,
        voteCount: voteCount,
        status: status,
        firstAirDate: firstAirDate,
        overview: overview,
        originalLanguage: originalLanguage,
        originalName: originalName,
        posterPath: posterPath,
        numberOfEpisodes: numberOfEpisodes,
        numberOfSeasons: numberOfSeasons);
  }

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
        id: id,
        genres: genres.map((e) => e.toEntity()).toList(),
        name: name,
        seasons: seasons != null ? (seasons!.map((e) => e.toEntity()).toList()) : null,
        voteAverage: voteAverage,
        voteCount: voteCount,
        status: status,
        firstAirDate: firstAirDate,
        overview: overview,
        originalLanguage: originalLanguage,
        originalName: originalName,
        posterPath: posterPath,
        numberOfEpisodes: numberOfEpisodes,
        numberOfSeasons: numberOfSeasons
    );
  }

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
        posterPath
      ];
}
