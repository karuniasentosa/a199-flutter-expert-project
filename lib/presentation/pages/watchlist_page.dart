import 'package:core/core.dart' show AppColors;
import 'package:ditonton/common/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/widgets.dart' show MovieCard;
import 'package:tv_series/tv_series.dart' show TvSeriesCard;

import 'package:tv_series/blocs.dart'
    show WatchlistTvSeriesCubit, WatchlistTvSeriesState,
         WatchlistTvSeriesResult, WatchlistTvSeriesError, WatchlistTvSeriesLoading;

import 'package:movie/blocs.dart'
    show WatchlistMoviesCubit, WatchlistMoviesState,
         WatchlistMoviesResult, WatchlistMoviesError, WatchlistMoviesLoading;

import 'package:flutter/material.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>
    with RouteAware, SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    Future.microtask(() {
      context.read<WatchlistMoviesCubit>()();
      context.read<WatchlistTvSeriesCubit>()();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Future.microtask(() {
      context.read<WatchlistMoviesCubit>()();
      context.read<WatchlistTvSeriesCubit>()();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
        bottom: TabBar(
          indicatorColor: AppColors.kMikadoYellow,
          controller: _tabController,
          tabs: const [
            Tab(text: 'Movies'),
            Tab(text: 'TV Series')
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _MovieWatchlistWidget(),
          _TvSeriesWatchlistWidget()
        ],
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

class _MovieWatchlistWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistMoviesCubit, WatchlistMoviesState>(
        builder: (context, state) {
          if (state is WatchlistMoviesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistMoviesResult) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return MovieCard(movie);
              },
              itemCount: state.movies.length,
            );
          } else if (state is WatchlistMoviesError){
            return Center(
              key: Key('error_message'),
              child: Text(state.errorMessage),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class _TvSeriesWatchlistWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
        builder: (context, state) {
          if (state is WatchlistTvSeriesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistTvSeriesResult) {
            if (state.tvSeries.isEmpty) {
              return Center(
                  child: Text("You haven't added any watchlists! Let's add some!")
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvSeries = state.tvSeries[index];
                return TvSeriesCard(tvSeries);
              },
              itemCount: state.tvSeries.length,
            );
          } else if (state is WatchlistTvSeriesError) {
            return Center(
              key: Key('error_message'),
              child: Text(state.errorMessage),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

}
