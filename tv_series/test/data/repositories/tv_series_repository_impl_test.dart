import 'package:dartz/dartz.dart';
import 'package:core/exception.dart';
import 'package:core/failure.dart';
import 'package:mockito/annotations.dart';
import 'package:tv_series/datasources.dart';
import 'package:tv_series/data/models/tv_series_model.dart';
import 'package:tv_series/data/repositories/tv_series_repository_impl.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_repository_impl_test.mocks.dart';

@GenerateMocks([TvSeriesRemoteDataSource, TvSeriesLocalDataSource])
void main() {
   late TvSeriesRepositoryImpl repository;
   late MockTvSeriesRemoteDataSource mockTvSeriesRemoteDataSource;
   late MockTvSeriesLocalDataSource mockTvSeriesLocalDataSource;

   setUp((){
     mockTvSeriesRemoteDataSource = MockTvSeriesRemoteDataSource();
     mockTvSeriesLocalDataSource = MockTvSeriesLocalDataSource();
     repository = TvSeriesRepositoryImpl(
       remoteDataSource: mockTvSeriesRemoteDataSource,
       localDataSource: mockTvSeriesLocalDataSource,
     );
   });

   final tTvSeriesModel = TvSeriesModel(
       posterPath: 'poster1.jpg',
       id: 34,
       name: 'Tv Series Name',
       overview: 'overview',
   );

   final tTvSeries = TvSeries(
       posterPath: 'poster1.jpg',
       id: 34,
       name: 'Tv Series Name',
       overview: 'overview',
   );

   final tTvSeriesModelList = <TvSeriesModel>[tTvSeriesModel];
   final tTvSeriesList = <TvSeries>[tTvSeries];

   group('Popular Tv Series',  () {
     test('should return remote data when all to remote data is successful', () async {
       // arrange
       when(mockTvSeriesRemoteDataSource.getPopularTvSeries())
           .thenAnswer((_) async => tTvSeriesModelList);

       // act
       final result = await repository.getPopularTvSeries();

       // asssert
       final resultList = result.getOrElse(() => []);
       expect(resultList, tTvSeriesList);
     });

     test('should throw error als;dkfj;alsdkfjasd;lfkj', () async {
       // arrange
       when(mockTvSeriesRemoteDataSource.getPopularTvSeries())
           .thenThrow(ServerException());

       // act
       final result = await repository.getPopularTvSeries();

       // assert
       expect(result, Left(ServerFailure('')));
     });
   });

   group('Top Rated TV Series', () {
     test('should return remote data when call to remote data is succesful', () async {
       // arrange
       when(mockTvSeriesRemoteDataSource.getTopRatedTvSeries())
           .thenAnswer((_) async => tTvSeriesModelList);

       // act
       final result = await repository.getTopRatedTvSeries();

       // asseert
       final resultList = result.getOrElse(() => []);
       expect(resultList, tTvSeriesList);
     });

     test('should return Failure when exception happens', () async {
       // arrange
       when(mockTvSeriesRemoteDataSource.getTopRatedTvSeries())
           .thenThrow(ServerException());

       // act
       final result = repository.getTopRatedTvSeries();

       expect(await result, Left(ServerFailure('')));
     });
   });

   group('Now playing tv series', () {
     test('should return hing from remote data when call to remote data is successful', () async {
       // arrange
       when(mockTvSeriesRemoteDataSource.getNowPlayingTvSeries())
           .thenAnswer((_) async => tTvSeriesModelList);

       // act
       final result = await repository.getNowPlayingTvSeries();

       // assert
       final resultLIst = result.getOrElse(() => []);
       expect(resultLIst, tTvSeriesList);
     });

     test('hsould return ServerFailure when exception is thrown', () async {
       // arrange
       when(mockTvSeriesRemoteDataSource.getNowPlayingTvSeries())
           .thenThrow(ServerException());

       // act
       final result = await repository.getNowPlayingTvSeries();

       // assert
       expect(result, Left(ServerFailure('')));
     });
   });

   group('Detail TV series', () {
     test('should return tv series detail data when call to remote is success', () async {
       // arrange
       when(mockTvSeriesRemoteDataSource.getTvSeriesDetail(id: 2))
           .thenAnswer((_) async => tTvSeriesDetailModel);

       // act
       final result = await repository.getTvSeriesDetail(id: 2);

       // assert
       expect(result.isRight(), true);
     });
     
     test('should return ServerFailure when throw exception', () async {
       // arrange
       when(mockTvSeriesRemoteDataSource.getTvSeriesDetail(id: 2))
           .thenThrow(ServerException())
           ;

       // act
       final result = await repository.getTvSeriesDetail(id: 2);

       // assert
       expect(result.isLeft(), true);
     });
   });

   group('Get recommendation from a TV Series', () {
     test('should return tv series recommendation when call to remote is success', () async {
       // arrange
       when(mockTvSeriesRemoteDataSource.getTvSeriesRecommendations(id: 2))
           .thenAnswer((_) async => tTvSeriesModelRecommendations);

       // act
       final result = await repository.getTvSeriesRecommendations(id: 2);

       // assert
       expect(result.isRight(), true);
     });
     test('should return failure when exception happens', () async {
       // ARRANGE
       when(mockTvSeriesRemoteDataSource.getTvSeriesRecommendations(id: 2))
           .thenThrow(ServerException());

       // act
       final result = await repository.getTvSeriesRecommendations(id: 2);

       // assert
       expect(result, Left(ServerFailure('')));
     });
   });

   group('Search tv series iisde a query', () {
     final query = "thrones";
     test('should return list of response when call to remote is success', () async {
       // arrange
       when(mockTvSeriesRemoteDataSource.searchTvSeries(query: query))
           .thenAnswer((_) async => tTvSeriesModelSearchResult);

       // act
       final result = await repository.searchTvSeries(query: query);

       // assert
       expect(result.isRight(), true);
     });

     test('should  return failure when thrown exception', () async {
       // arrange
       when(mockTvSeriesRemoteDataSource.searchTvSeries(query: query))
           .thenThrow(ServerException());

       // act
       final result = await repository.searchTvSeries(query: query);

       // assert
       expect(result, Left(ServerFailure('')));
     });
   });

   group('Watchlist TV Series', () {
     final tvSeriesModel = TvSeriesModel.fromTvSeriesDetail(tTvSeriesDetail);
     group('insert watchlist', (){
       test('should add the watchlist to database', () async {
         // arrange
         when(mockTvSeriesLocalDataSource.insertWatchlist(tvSeriesModel))
             .thenAnswer((_) async => true);

         // act
         final result = repository.insertWatchlist(tTvSeriesDetail);

         // assert
         expect(await result, Right(true));
       });
       test('should return DatabaseFailure when exception is thrown', () async {
         // arrange
         when(mockTvSeriesLocalDataSource.insertWatchlist(tvSeriesModel))
             .thenThrow(DatabaseException('unable to retrieve'));

         // act
         final result = repository.insertWatchlist(tTvSeriesDetail);

         // assert
         expect(await result, Left(DatabaseFailure('unable to retrieve')));
       });
     });
     
     group('retrieve watchlist', () {
       test('should retrieve data from the local database to get watchlist status', () async {
         // arrange
         when(mockTvSeriesLocalDataSource.getWatchlistStatus(tvSeriesModel.id))
             .thenAnswer((_) async => true);

         // act
         final result = repository.getWatchlistStatus(tvSeriesModel.id);

         // assert
         expect(await result, Right(true));
       });
       test("should return database failure when exception happens", () async {
         // arrange
         when(mockTvSeriesLocalDataSource.getWatchlistStatus(tvSeriesModel.id))
             .thenThrow(DatabaseException('error!'));

         // act
         final result = repository.getWatchlistStatus(tvSeriesModel.id);

         // assert
         expect(await result, Left(DatabaseFailure('error!')));
       });
     });

     group('remove watchlist', () {
       test('should remove the watchlist from database', () async {
         // arrange
         when(mockTvSeriesLocalDataSource.removeWatchlist(2))
             .thenAnswer((_) async => true);

         // act
         final result = repository.removeWatchlist(2);

         // assert
         expect(await result, Right(true));
       });
       test('should return databasefailure when exception throws', () async {
         // arrange
         when(mockTvSeriesLocalDataSource.removeWatchlist(2))
             .thenThrow(DatabaseException('a'));

         // act
         final result = repository.removeWatchlist(2);

         // assert
         expect(await result, Left(DatabaseFailure('a')));
       });
     });

     group('all watchlist', () {
       test('should retreive all watchlist that has been inserted', () async {
         // arrange
         when(mockTvSeriesLocalDataSource.getAllWatchlist())
             .thenAnswer((_) async => tTvSeriesModelWatchlist);

         // act
         final result = await repository.getWatchlistTvSeries();

         // asserrt
         expect(result.isRight(), true);
       });

       test('should return failure when exception happens', () async {
         // arrange
         when(mockTvSeriesLocalDataSource.getAllWatchlist())
             .thenThrow(DatabaseException('just joking'));

         // act
         final result = await repository.getWatchlistTvSeries();

         // assert
         expect(result, Left(DatabaseFailure('just joking')));
       });
     });

   });
}
