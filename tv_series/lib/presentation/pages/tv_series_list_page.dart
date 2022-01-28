import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import '../../domain/entities/tv_series.dart';
import 'now_playing_tv_series_page.dart';
import 'popular_tv_series_page.dart';
import 'tv_series_detail_page.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvSeriesListPage extends StatefulWidget {
  static const routeName = '/home-tv';

  const TvSeriesListPage({Key? key}) : super(key: key);

  @override
  State<TvSeriesListPage> createState() => _TvSeriesListPageState();
}

class _TvSeriesListPageState extends State<TvSeriesListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<TvSeriesListNotifier>(context, listen: false)
          ..fetchPopularTvSeries()
          ..fetchTopRatedTvSeries()
          ..fetchNowPlayingTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubHeading(
                title: 'Now playing',
                onTap: () {
                  Navigator.pushNamed(
                      context, NowPlayingTvSeriesPage.routeName);
                }),
            Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
              final state = data.nowPlayingTvSeriesState;
              if (state == RequestState.Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return TvSeriesList(data.nowPlayingTvSeriesList);
              } else if (state == RequestState.Empty) {
                return const Text('No now playing tv series available :(');
              } else {
                return Text(
                    'An Error occurred: ${data.topRatedTvSeriesErrorMessage}');
              }
            }),
            _buildSubHeading(
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(context, PopularTvSeriesPage.routeName);
                }),
            Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
              final state = data.popularTvSeriesState;
              if (state == RequestState.Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return TvSeriesList(data.popularTvSeriesList);
              } else if (state == RequestState.Empty) {
                return const Text('No popular tv series available :(');
              } else {
                return Text(
                    'Erro r occured: ${data.popularTvSeriesErrorMessage}');
              }
            }),
            _buildSubHeading(title: 'Top Rated', onTap: null),
            Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
              final state = data.topRatedTvSeriesState;
              if (state == RequestState.Loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state == RequestState.Loaded) {
                return TvSeriesList(data.topRatedTvSeriesList);
              } else if (state == RequestState.Empty) {
                return const Text('No top rated tv series avaibale :(');
              } else {
                return Text(
                    'Error occured: ${data.topRatedTvSeriesErrorMessage}');
              }
            }),
          ],
        )));
  }

  Row _buildSubHeading({required String title, Function()? onTap}) {
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
}

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeries;

  const TvSeriesList(this.tvSeries, {Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final series = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvSeriesDetailPage.routeName,
                  arguments: series.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w500${series.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
