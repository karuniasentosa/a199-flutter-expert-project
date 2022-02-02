import 'package:mockito/annotations.dart';
import 'package:tv_series/usecases.dart';

@GenerateMocks([
  GetNowPlayingTvSeries, GetPopularTvSeries,
  GetTopRatedTvSeries, GetTvSeriesDetail,
  GetTvSeriesRecommendation, GetWatchlistTvSeries,
  GetWatchlistTvSeriesStatus, InsertWatchlistTvSeries,
  RemoveWatchlistTvSeries, SearchTvSeries
])
void main() {}