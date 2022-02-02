import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_series/top_rated_tv_series_cubit.dart';
import '../../domain/entities/tv_series.dart';
import 'now_playing_tv_series_page.dart';
import 'popular_tv_series_page.dart';
import 'tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/tv_series_list_page_bloc.dart';

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
    Future.microtask((){
      context.read<PopularTvSeriesCubit>()();
      context.read<NowPlayingTvSeriesCubit>()();
      context.read<TopRatedTvSeriesCubit>()();
    });
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
            BlocBuilder<NowPlayingTvSeriesCubit, NowPlayingTvSeriesState>(
                builder: (context, state) {
              if (state is NowPlayingTvSeriesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NowPlayingTvSeriesResult) {
                return TvSeriesList(state.tvSeries);
              } else if (state is NowPlayingTvSeriesError) {
                return Text(
                    'An Error occurred: ${state.errorMessage}');
              } else {
                return Container();
              }
            }),
            _buildSubHeading(
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(context, PopularTvSeriesPage.routeName);
                }),
            BlocBuilder<PopularTvSeriesCubit, PopularTvSeriesState>(
                builder: (context, state) {
              if (state is PopularTvSeriesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PopularTvSeriesResult) {
                return TvSeriesList(state.tvSeries);
              } else if (state is PopularTvSeriesError) {
                return Text(
                    'Erro r occured: ${state.errorMessage}');
              } else {
                return Container();
              }
            }),
            _buildSubHeading(title: 'Top Rated', onTap: null),
            BlocBuilder<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
                builder: (context, state) {
              if (state is TopRatedTvSeriesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TopRatedTvSeriesResult) {
                return TvSeriesList(state.tvSeries);
              } else if (state is TopRatedTvSeriesError) {
                return Text(
                    'Error occured: ${state.errorMessage}');
              } else {
                return Container();
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
