import 'package:tv_series/data/models/genre_model.dart';
import 'package:tv_series/data/models/season_model.dart';
import 'package:tv_series/data/models/tv_series_detail_model.dart';
import 'package:tv_series/data/models/tv_series_model.dart';
import 'package:tv_series/domain/entities/genre.dart';
import 'package:tv_series/domain/entities/season.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';

final _genreModel = [
  GenreModel(id: 534, name: "Action"),
  GenreModel(id: 995, name: "Sports")
];

final _seasonModel = [
  SeasonModel(id: 1, posterPath: 'a', name: 'asd', overview: 'fgh', seasonNumber: 1),
  SeasonModel(id: 2, posterPath: 'b', name: 'jkl', overview: 'mno', seasonNumber: 2)
];

final _genres = List<Genre>.from(_genreModel.map((e) => e.toEntity()), growable: false);
final _seasons = List<Season>.from(_seasonModel.map((e) => e.toEntity()), growable: false);

final tTvSeriesDetailModel = TvSeriesDetailModel(
  id: 2,
  genres: _genreModel,
  posterPath: '/a',
  name: 'A',
  voteAverage: 7.5,
  voteCount: 40,
  status: 'Released',
  firstAirDate: '2020-10-11',
  overview: 'A people who thinks they are great.',
  originalLanguage: 'en',
  originalName: '月は君の嘘',
  numberOfEpisodes: 22,
  numberOfSeasons: 2,
);

final tTvSeriesDetailModelWithSeasons = TvSeriesDetailModel(
  id: 2,
  genres: _genreModel,
  seasons: _seasonModel,
  posterPath: '/a',
  name: 'A',
  voteAverage: 7.5,
  voteCount: 40,
  status: 'Released',
  firstAirDate: '2020-10-11',
  overview: 'A people who thinks they are great.',
  originalLanguage: 'en',
  originalName: '月は君の嘘',
  numberOfEpisodes: 22,
  numberOfSeasons: 2,
);

final tTvSeriesDetail = TvSeriesDetail(
  id: 2,
  genres: _genres,
  posterPath: '/a',
  name: 'A',
  voteAverage: 7.5,
  voteCount: 40,
  status: 'Released',
  firstAirDate: '2020-10-11',
  overview: 'A people who thinks they are great.',
  originalLanguage: 'en',
  originalName: '月は君の嘘',
  numberOfEpisodes: 22,
  numberOfSeasons: 2,
);

final tTvSeriesDetailWithSeasons = TvSeriesDetail(
  id: 2,
  genres: _genres,
  seasons: _seasons,
  posterPath: '/a',
  name: 'A',
  voteAverage: 7.5,
  voteCount: 40,
  status: 'Released',
  firstAirDate: '2020-10-11',
  overview: 'A people who thinks they are great.',
  originalLanguage: 'en',
  originalName: '月は君の嘘',
  numberOfEpisodes: 22,
  numberOfSeasons: 2,
);

final tTvSeriesModelRecommendations = <TvSeriesModel>[
  TvSeriesModel(
      posterPath: "/aurZJ8UsXqhGwwBnNuZsPNepY8y.jpg",
      id: 64122,
      name: "The Shannara Chronicles",
      overview: "A young Healer armed with an unpredictable magic guides a runaway Elf in her perilous quest to save the peoples of the Four Lands from an age-old Demon scourge.",
  ),
  TvSeriesModel(
      posterPath: "/8T8bAVzaKKyDNGQ6DQB3HF80wbJ.jpg",
      id: 44305,
      name: "DreamWorks Dragons",
      overview: "DreamWorks Dragons is an American computer-animated television series airing on Cartoon Network based on the 2010 film How to Train Your Dragon. The series serves as a bridge between the first film and its 2014 sequel. Riders of Berk follows Hiccup as he tries to keep balance within the new cohabitation of Dragons and Vikings. Alongside keeping up with Berk's newest installment — A Dragon Training Academy — Hiccup, Toothless, and the rest of the Viking Teens are put to the test when they are faced with new worlds harsher than Berk, new dragons that can't all be trained, and new enemies who are looking for every reason to destroy the harmony between Vikings and Dragons all together.",
  ),
  TvSeriesModel(
      posterPath: "/ydmfheI5cJ4NrgcupDEwk8I8y5q.jpg",
      id: 1405,
      name: "Dexter",
      overview: "Dexter is an American television drama series. The series centers on Dexter Morgan, a blood spatter pattern analyst for 'Miami Metro Police Department' who also leads a secret life as a serial killer, hunting down criminals who have slipped through the cracks of justice.",
  )
];

final tTvSeriesRecommendation = List<TvSeries>.from(tTvSeriesModelRecommendations.map((e) => e.toEntity()));

final tTvSeriesModelSearchResult = <TvSeriesModel>[
  TvSeriesModel(
      posterPath: "/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg",
      id: 1399,
      name: "Game of Thrones",
      overview: "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
  )
];

final tTvSeriesSearchResult = List<TvSeries>.from(tTvSeriesModelSearchResult.map((e) => e.toEntity()));


final tTvSeriesWatchlist = List<TvSeries>.from(tTvSeriesRecommendation);

final tTvSeriesWatchlistMap = List<Map<String, dynamic>>
    .from(tTvSeriesWatchlist.map(
        (e) => TvSeriesModel(
            id: e.id,
            name: e.name,
            overview: e.overview,
            posterPath: e.posterPath).toJson()
    ));

final tTvSeriesModelWatchlist = List<TvSeriesModel>
    .from(tTvSeriesWatchlistMap.map(
        (e) => TvSeriesModel.fromJsonMapDatabase(e)));
