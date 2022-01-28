import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:tv_series/domain/entities/genre.dart';
import '../../domain/entities/tv_series_detail.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_detail_notifier.dart';
import '../widgets/season_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'tv_series_list_page.dart' show TvSeriesList;
import 'package:core/appcolor.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const routeName = '/tv-detail';

  final int tvSeriesId;

  const TvSeriesDetailPage({required this.tvSeriesId, Key? key}): super(key: key);

  @override
  State<TvSeriesDetailPage> createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvSeriesDetailNotifier>(context, listen: false)
        .fetchTvSeriesDetail(widget.tvSeriesId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvSeriesDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvSeriesDetailState == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvSeriesDetailState == RequestState.Loaded) {
            final tvSeries = provider.tvSeriesDetail;
            final isAddedToWatchlist = provider.addedToWatchlist;
            return SafeArea(
                child: TvSeriesDetailContent(
              tvSeries: tvSeries!,
              isAddedToWatchlist: isAddedToWatchlist,
            ));
          } else {
            return Text(provider.tvSeriesDetailErrorMessage);
          }
        },
      ),
    );
  }
}

class TvSeriesDetailContent extends StatelessWidget {
  final TvSeriesDetail tvSeries;
  final bool isAddedToWatchlist;

  const TvSeriesDetailContent(
      {
        required this.tvSeries,
        required this.isAddedToWatchlist,
        Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(children: [
      CachedNetworkImage(
        imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
        width: screenWidth,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      Container(
        margin: const EdgeInsets.only(top: 48 + 8),
        child: DraggableScrollableSheet(
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: AppColors.kRichBlack,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              padding: const EdgeInsets.only(
                left: 16,
                top: 16,
                right: 16,
              ),
              child: Stack(children: [
                Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tvSeries.name,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              tvSeries.name != tvSeries.originalName
                                  ? Text(
                                      '(${tvSeries.originalName})',
                                    )
                                  : SizedBox(height: 8),
                              ElevatedButton(
                                  onPressed: () async {
                                    if (!isAddedToWatchlist) {
                                      await Provider.of<TvSeriesDetailNotifier>(
                                              context,
                                              listen: false)
                                          .insertToWatchlist();

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text('Added to watchlist')));
                                    } else {
                                      await Provider.of<TvSeriesDetailNotifier>(
                                              context,
                                              listen: false)
                                          .removeFromWatchlist();

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Removed from watchlist')));
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      isAddedToWatchlist
                                          ? const Icon(Icons.check)
                                          : const Icon(Icons.save_alt),
                                      const Text('Watchlist')
                                    ],
                                  )),
                              Text(_showGenres(tvSeries.genres)),
                              Text(_describeSeasonsEpisodes(
                                  tvSeries.numberOfSeasons,
                                  tvSeries.numberOfEpisodes)),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: tvSeries.voteAverage.toDouble() / 2,
                                    itemCount: 5,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: AppColors.kMikadoYellow,
                                    ),
                                    itemSize: 24,
                                  ),
                                  Text('${tvSeries.voteAverage / 2}'),
                                  Text('(${tvSeries.voteCount} votes)')
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text('Overview', style: Theme.of(context).textTheme.headline6),
                              Text(tvSeries.overview),
                              const SizedBox(height: 16),
                              _buildSubHeading(context, title: 'Seasons', onTap: null),
                              SizedBox(
                                height: 200,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: tvSeries.seasons!.length,
                                    itemBuilder: (context, index) {
                                      final season = tvSeries.seasons![index];
                                      return SeasonCard(season);
                                    }
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text('Recommendations', style: Theme.of(context).textTheme.headline6),
                              Consumer<TvSeriesDetailNotifier>(
                                builder: (context, provider, child) {
                                  if (provider.tvSeriesRecommendationState ==
                                      RequestState.Loading) {
                                    return const SizedBox(
                                      height: 32,
                                      child: Center(
                                          child: Text(
                                              'Fetching recommendations...')),
                                    );
                                  } else if (provider
                                          .tvSeriesRecommendationState ==
                                      RequestState.Loaded) {
                                    final list =
                                        provider.tvSeriesRecommendationList;
                                    return TvSeriesList(list);
                                  } else if (provider
                                          .tvSeriesRecommendationState ==
                                      RequestState.Empty) {
                                    return const SizedBox(
                                      height: 32,
                                      child: Center(
                                          child: Text(
                                              'No recommendations available')),
                                    );
                                  } else {
                                    return const Text('unknown error');
                                  }
                                },
                              )
                            ]))),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    color: Colors.white,
                    height: 4,
                    width: 48,
                  ),
                ),
              ]),
            );
          },
          minChildSize: 0.25,
        ),
      ),
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
              backgroundColor: AppColors.kRichBlack,
              foregroundColor: Colors.white,
              child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context))))
    ]);
  }

  Row _buildSubHeading(BuildContext context, {required String title, Function()? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        onTap != null
            ? InkWell(
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _describeSeasonsEpisodes(int numberOfSeasons, int numberOfEpisodes) {
    String result = '';
    result += '$numberOfSeasons';
    if (numberOfSeasons > 1) {
      result += ' seasons, ';
    } else {
      result += ' season, ';
    }

    result += '$numberOfEpisodes';
    if (numberOfEpisodes > 1) {
      result += ' episode ';
    } else {
      result += ' episodes ';
    }

    return (result += 'total');
  }
}
