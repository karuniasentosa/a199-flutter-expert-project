import 'package:equatable/equatable.dart';

class Season extends Equatable {
  final int id;
  final String? posterPath;
  final String name;
  final String overview;
  final int seasonNumber;

  Season({
    required this.id,
    required this.posterPath,
    required this.name,
    required this.overview,
    required this.seasonNumber
  });

  @override
  List<Object?> get props => [id, posterPath, name, overview, seasonNumber];
}