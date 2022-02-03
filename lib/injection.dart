import 'dart:io';

import 'package:core/core.dart' show DatabaseHelper;
import 'package:flutter/services.dart';
import 'package:http/io_client.dart';
import 'package:movie/data/datasources/db/movie_database_helper.dart';

import 'package:movie/usecases.dart';
import 'package:movie/datasources.dart';
import 'package:movie/repositories.dart';
import 'package:movie/blocs.dart';
import 'package:tv_series/data/datasources/db/tv_series_database_helper.dart';

import 'package:tv_series/usecases.dart';
import 'package:tv_series/datasources.dart';
import 'package:tv_series/repositories.dart';
import 'package:tv_series/blocs.dart';

import 'package:get_it/get_it.dart';


final locator = GetIt.instance;

void init() {
  // external
  locator.registerSingletonAsync<IOClient>(() async {
    final byteData = await rootBundle.load('cert/_.themoviedb.org.pem');
    final securityContext = SecurityContext()
      ..setTrustedCertificatesBytes(byteData.buffer.asInt8List());
    final http = HttpClient(context: securityContext);
    return IOClient(http);
  });

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
  locator.registerFactory(() => WatchlistMoviesCubit(locator()));

  locator.registerFactory(() => PopularTvSeriesCubit(locator()));
  locator.registerFactory(() => NowPlayingTvSeriesCubit(locator()));
  locator.registerFactory(() => TopRatedTvSeriesCubit(locator()));
  locator.registerFactory(() => TvSeriesDetailCubit(locator()));
  locator.registerFactory(() => TvSeriesRecommendationCubit(locator()));
  locator.registerFactory(() => TvSeriesWatchlistBloc(
    getWatchlistTvSeriesStatus: locator(),
    insertWatchlistTvSeries: locator(),
    removeWatchlistTvSeries: locator()
  ));
  locator.registerFactory(() => SearchTvSeriesCubit(locator()));
  locator.registerFactory(() => WatchlistTvSeriesCubit(locator()));


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

  // helper
  locator.registerSingleton<DatabaseHelper>(DatabaseHelper());
  locator.registerSingleton<MovieDatabaseHelper>(MovieDatabaseHelper());
  locator.registerSingleton<TvSeriesDatabaseHelper>(TvSeriesDatabaseHelper());

  // data sources
  locator.registerSingletonWithDependencies<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()),
      dependsOn: [IOClient]
  );
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerSingletonWithDependencies<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()),
      dependsOn: [IOClient]
  );
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
          () => TvSeriesLocalDataSourceImpl(databaseHelper: locator())
  );

  // repository
  locator.registerSingletonWithDependencies<MovieRepository>(
          () => MovieRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
      ),
      dependsOn: [MovieRemoteDataSource]
  );

  locator.registerSingletonWithDependencies<TvSeriesRepository>(
          () => TvSeriesRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource:  locator(),
      ),
      dependsOn: [TvSeriesRemoteDataSource]
  );
}
