import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesModel extends Equatable {
  final String? posterPath;
  final int id;
  final String name;
  final String overview;

  TvSeriesModel(
      {
       this.posterPath,
       required this.id,
       required this.name,
       required this.overview});

  factory TvSeriesModel.fromJsonMap(Map<String, dynamic> jsonMap) =>
      TvSeriesModel(
          id: jsonMap['id'],
          name: jsonMap['name'],
          overview: jsonMap['overview'],
          posterPath: jsonMap['poster_path']
      );

  factory TvSeriesModel.fromJsonMapDatabase(Map<String, dynamic> jsonMap) =>
      TvSeriesModel(
          id: jsonMap['id'],
          name: jsonMap['name'],
          overview: jsonMap['overview'],
          posterPath: jsonMap['posterPath']
      );

  factory TvSeriesModel.fromTvSeriesDetail(TvSeriesDetail detail) =>
      TvSeriesModel(
          id: detail.id,
          name: detail.name,
          overview: detail.overview,
          posterPath: detail.posterPath);

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "overview": overview,
    "posterPath": posterPath,
  };

  TvSeries toEntity() {
    return TvSeries(
        id: id,
        name: name,
        overview: overview,
        posterPath: posterPath
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    overview,
    posterPath
  ];
}
