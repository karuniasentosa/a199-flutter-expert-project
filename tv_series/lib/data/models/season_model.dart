import 'package:tv_series/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class SeasonModel extends Equatable {
  final int id;
  final String? posterPath;
  final String name;
  final String overview;
  final int seasonNumber;

  SeasonModel({
    this.posterPath,
    required this.id,
    required this.name,
    required this.overview,
    required this.seasonNumber,
  });

  factory SeasonModel.fromJsonMap(Map<String, dynamic> jsonMap) =>
      SeasonModel(
          id: jsonMap['id'],
          posterPath: jsonMap['poster_path'],
          name: jsonMap['name'],
          overview: jsonMap['overview'],
          seasonNumber: jsonMap['season_number']
      );

  Season toEntity() =>
      Season(
          id: id,
          posterPath: posterPath,
          name: name,
          overview: overview,
          seasonNumber: seasonNumber
      );

  @override
  List<Object?> get props => [id, posterPath, name, overview, seasonNumber];

}