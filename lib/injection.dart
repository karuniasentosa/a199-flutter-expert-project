import 'package:core/core.dart' show DatabaseHelper;

import 'package:movie/usecases.dart';
import 'package:movie/datasources.dart';
import 'package:movie/repositories.dart';
import 'package:movie/blocs.dart';

import 'package:tv_series/usecases.dart';
import 'package:tv_series/datasources.dart';
import 'package:tv_series/repositories.dart';

import 'package:ditonton/presentation/provider/tv_series/now_playing_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_watchlist_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'presentation/provider/tv_series/popular_tv_series_notifier.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(() => NowPlayingMoviesCubit(locator()));
  locator.registerFactory(() => PopularMoviesCubit(locator()));
  locator.registerFactory(() => TopRatedMoviesCubit(locator()));

  locator.registerFactory(() => MovieDetailCubit(locator()));
  locator.registerFactory(() => MovieRecommendationsCubit(locator()));
  locator.registerFactory(() => MovieWatchlistBloc(
    getWatchlistStatus: locator(),
    saveWatchlist: locator(),
    removeWatchlist: locator()
  ));
  locator.registerFactory(() => SearchMoviesCubit(locator()));

  // locator.registerFactory(
  //   () => WatchlistMovieNotifier(
  //     getWatchlistMovies: locator(),
  //   ),
  // );

  locator.registerFactory(() => PopularTvSeriesNotifier(locator()));
  locator.registerFactory(() => NowPlayingTvSeriesNotifier(locator()));
  locator.registerFactory(() => TvSeriesDetailNotifier(
      getTvSeriesDetail: locator(),
      getTvSeriesRecommendation: locator(),
      insertWatchlistTvSeries: locator(),
      getWatchlistTvSeriesStatus: locator(),
      removeWatchlistTvSeries: locator(),
  ));
  locator.registerFactory(() => TvSeriesListNotifier(
      getPopularTvSeries: locator(),
      getTopRatedTvSeries: locator(),
      getNowPlayingTvSeries: locator())
  );
  locator.registerFactory(() => TvSeriesSearchNotifier(locator()));
  locator.registerFactory(() => TvSeriesWatchlistNotifier(
      getWatchlistTvSeries: locator())
  );


  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetNowPlayingTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendation(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeriesStatus(locator()));
  locator.registerLazySingleton(() => InsertWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvSeriesRepository>(
          () => TvSeriesRepositoryImpl(
              remoteDataSource: locator(),
              localDataSource:  locator(),
          )
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator())
  );
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
          () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
