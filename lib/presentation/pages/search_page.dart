import 'package:ditonton/common/constants.dart' show SearchContext;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/blocs.dart'
    show SearchTvSeriesCubit, SearchTvSeriesResult,
         SearchTvSeriesLoading, SearchTvSeriesState;
import 'package:movie/blocs.dart'
    show SearchMoviesCubit, SearchMoviesState,
         SearchMoviesResult, SearchMoviesLoading;
import 'package:tv_series/tv_series.dart' show TvSeriesCard;
import 'package:movie/movie.dart' show MovieCard;
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';
  
  final SearchContext searchContext;
  
  SearchPage(this.searchContext);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                switch(searchContext) {
                  case SearchContext.movie:
                    context.read<SearchMoviesCubit>()(query);
                    return;
                  case SearchContext.tvSeries:
                    context.read<SearchTvSeriesCubit>()(query);
                }
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: Theme.of(context).textTheme.headline6,
            ),
            searchContext == SearchContext.movie ?
                _MovieSearchResultWidget() :
                _TvSeriesSearchResultWidget(),
          ],
        ),
      ),
    );
  }
}

class _MovieSearchResultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchMoviesCubit, SearchMoviesState>(
      builder: (context, state) {
        if (state is SearchMoviesLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchMoviesResult) {
          final result = state.movies;
          if (result.isEmpty) {
            return Center(
                child: Text('No results found :(')
            );
          }
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final movie = result[index];
                return MovieCard(movie);
              },
              itemCount: result.length,
            ),
          );
        } else {
          return Expanded(
            child: Container(),
          );
        }
      },
    );
  }
}

class _TvSeriesSearchResultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchTvSeriesCubit, SearchTvSeriesState>(
      builder: (context, state) {
        if (state is SearchTvSeriesLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchTvSeriesResult) {
          final result = state.tvSeries;
          if (result.isEmpty) {
            return Center(
                child: Text('No results found :(')
            );
          }
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final tvSeries = result[index];
                return TvSeriesCard(tvSeries);
              },
              itemCount: result.length,
            ),
          );
        } else {
          return Expanded(
            child: Container(),
          );
        }
      },
    );
  }
}