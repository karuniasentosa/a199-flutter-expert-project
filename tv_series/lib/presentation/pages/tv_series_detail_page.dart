import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/genre.dart';
import 'package:tv_series/presentation/bloc/tv_series_detail_page_bloc.dart';
import '../../domain/entities/tv_series_detail.dart';
import '../widgets/season_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'tv_series_list_page.dart' show TvSeriesList;
import 'package:core/appcolor.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const routeName = '/tv-detail';

  final int tvSeriesId;

  const TvSeriesDetailPage({required this.tvSeriesId, Key? key})
      : super(key: key);

  @override
  State<TvSeriesDetailPage> createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvSeriesDetailCubit>()(widget.tvSeriesId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvSeriesDetailCubit, TvSeriesDetailState>(
        builder: (context, state) {
          if (state is TvSeriesDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvSeriesDetailResult) {
            final tvSeries = state.tvSeriesDetail;
            return SafeArea(child: TvSeriesDetailContent(tvSeries: tvSeries));
          } else if (state is TvSeriesDetailError) {
            return Text(state.errorMessage);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class TvSeriesDetailContent extends StatefulWidget {
  final TvSeriesDetail tvSeries;

  const TvSeriesDetailContent({required this.tvSeries, Key? key})
      : super(key: key);

  @override
  State<TvSeriesDetailContent> createState() => _TvSeriesDetailContentState();
}

class _TvSeriesDetailContentState extends State<TvSeriesDetailContent> {
  @override
  void initState() {
    context
        .read<TvSeriesWatchlistBloc>()
        .add(WatchlistStatusGet(widget.tvSeries.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(children: [
      CachedNetworkImage(
        imageUrl:
            'https://image.tmdb.org/t/p/w500${widget.tvSeries.posterPath}',
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
                                widget.tvSeries.name,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              widget.tvSeries.name !=
                                      widget.tvSeries.originalName
                                  ? Text(
                                      '(${widget.tvSeries.originalName})',
                                    )
                                  : const SizedBox(height: 8),
                              BlocConsumer<TvSeriesWatchlistBloc,
                                  TvSeriesWatchlistState>(
                                listener: (context, state) {
                                  if (state is InsertWatchlistSuccess) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'insert watchlist success')));
                                  } else if (state is InsertWatchlistError) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(state.errorMessage),
                                          );
                                        });
                                  }

                                  if (state is RemoveWatchlistSuccess) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'remove watchlist success')));
                                  } else if (state is RemoveWatchlistError){
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(state.errorMessage),
                                          );
                                        });
                                  }
                                },
                                listenWhen: (_, current) =>
                                    current is TvSeriesInsertWatchlistState ||
                                    current is TvSeriesRemoveWatchlistState,
                                builder: (context, state) {
                                  final isAddedToWatchlist =
                                      (state as TvSeriesWatchlistStatusResult).watchlisted;
                                  return ElevatedButton(
                                      onPressed: () async {
                                        if (!isAddedToWatchlist) {
                                          context.read<TvSeriesWatchlistBloc>()
                                              .add(WatchlistInsert(widget.tvSeries));
                                        } else {
                                          context.read<TvSeriesWatchlistBloc>()
                                              .add(WatchlistRemove(widget.tvSeries.id));
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
                                      ));
                                },
                              ),
                              Text(_showGenres(widget.tvSeries.genres)),
                              Text(_describeSeasonsEpisodes(
                                  widget.tvSeries.numberOfSeasons,
                                  widget.tvSeries.numberOfEpisodes)),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating:
                                        widget.tvSeries.voteAverage.toDouble() /
                                            2,
                                    itemCount: 5,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: AppColors.kMikadoYellow,
                                    ),
                                    itemSize: 24,
                                  ),
                                  Text('${widget.tvSeries.voteAverage / 2}'),
                                  Text('(${widget.tvSeries.voteCount} votes)')
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text('Overview',
                                  style: Theme.of(context).textTheme.headline6),
                              Text(widget.tvSeries.overview),
                              const SizedBox(height: 16),
                              _buildSubHeading(context,
                                  title: 'Seasons', onTap: null),
                              SizedBox(
                                height: 200,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: widget.tvSeries.seasons!.length,
                                    itemBuilder: (context, index) {
                                      final season =
                                          widget.tvSeries.seasons![index];
                                      return SeasonCard(season);
                                    }),
                              ),
                              const SizedBox(height: 16),
                              Text('Recommendations',
                                  style: Theme.of(context).textTheme.headline6),
                              BlocBuilder<TvSeriesRecommendationCubit, TvSeriesRecommendationState>(
                                builder: (context, state) {
                                  if (state is TvSeriesRecommendationLoading) {
                                    return const SizedBox(
                                      height: 32,
                                      child: Center(
                                          child: Text(
                                              'Fetching recommendations...')),
                                    );
                                  } else if (state is TvSeriesRecommendationResult) {
                                    if (state.tvSeries.isEmpty) {
                                      return const SizedBox(
                                        height: 32,
                                        child: Center(
                                            child: Text(
                                                'No recommendations available')),
                                      );
                                    } else {
                                      final list =
                                          state.tvSeries;
                                      return TvSeriesList(list);
                                    }
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

  Row _buildSubHeading(BuildContext context,
      {required String title, Function()? onTap}) {
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
                    children: const [
                      Text('See More'),
                      Icon(Icons.arrow_forward_ios)
                    ],
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
