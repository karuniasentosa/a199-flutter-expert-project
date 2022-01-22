import 'package:ditonton/common/constants.dart' show SearchContext, kHeading6;
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/movie/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_search_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                    Provider.of<MovieSearchNotifier>(context, listen: false)
                        .fetchMovieSearch(query);
                    return;
                  case SearchContext.tvSeries:
                    Provider.of<TvSeriesSearchNotifier>(context, listen: false)
                        .doSearchTvSeries(query);
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
              style: kHeading6,
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
    return Consumer<MovieSearchNotifier>(
      builder: (context, data, child) {
        if (data.state == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.state == RequestState.Loaded) {
          final result = data.searchResult;
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final movie = data.searchResult[index];
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
    return Consumer<TvSeriesSearchNotifier>(
      builder: (context, provider, child) {
        if (provider.state == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (provider.state == RequestState.Loaded) {
          final result = provider.searchResultList;
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
        } else if (provider.state == RequestState.Empty) {
          return Center(
            child: Text('No results found :(')
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