import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_series/now_playing_tv_series_notifier.dart';
import '../widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NowPlayingTvSeriesPage extends StatefulWidget {
  static const routeName = '/now-playing-tv';

  const NowPlayingTvSeriesPage({Key? key}) : super(key: key);

  @override
  State<NowPlayingTvSeriesPage> createState() => _PopularTvSeriesPage();
}

class _PopularTvSeriesPage extends State<NowPlayingTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<NowPlayingTvSeriesNotifier>(context, listen: false)
            .fetchNowPlayingTvSeries()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<NowPlayingTvSeriesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = data.tvSeriesList[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: data.tvSeriesList.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.errorMessage),
              );
            }
          },
        ),
      ),
    );
  }
}