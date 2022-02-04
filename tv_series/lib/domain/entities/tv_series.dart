import 'package:equatable/equatable.dart';

class TvSeries with EquatableMixin {
  final String? posterPath;
  final int id;
  final String name;
  final String overview;

  TvSeries(
      {this.posterPath,
      required this.id,
      required this.name,
      required this.overview});

  @override
  List<Object?> get props => [id, name, overview, posterPath];
}
