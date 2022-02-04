import 'package:equatable/equatable.dart';

import 'tv_series_model.dart';

class TvSeriesResponse extends Equatable {
  final List<TvSeriesModel> showList;

  TvSeriesResponse({required this.showList});

  factory TvSeriesResponse.fromJsonMap(Map<String, dynamic> json) =>
      TvSeriesResponse(
          showList: (json["results"] as List)
              .map<TvSeriesModel>((e) => TvSeriesModel.fromJsonMap(e))
              .where((element) => element.posterPath != null)
              .toList());

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(showList.map((e) => e.toJson())),
      };

  @override
  List<Object?> get props => [showList];
}
