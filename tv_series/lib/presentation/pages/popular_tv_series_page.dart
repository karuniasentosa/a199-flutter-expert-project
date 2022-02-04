import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../bloc/popular_tv_series_page_bloc.dart';
import '../widgets/tv_series_card_list.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const routeName = '/popular-tv';

  const PopularTvSeriesPage({Key? key}) : super(key: key);

  @override
  State<PopularTvSeriesPage> createState() => _PopularTvSeriesPage();
}

class _PopularTvSeriesPage extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<PopularTvSeriesCubit>()());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvSeriesCubit, PopularTvSeriesState>(
          builder: (context, state) {
            if (state is PopularTvSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvSeriesResult) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = state.tvSeries[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: state.tvSeries.length,
              );
            } else if (state is PopularTvSeriesError) {
              FirebaseCrashlytics.instance.log(
                  'PopularTvSeriesPage PopularTvSeries error ${state.errorMessage}');
              return Center(
                key: const Key('error_message'),
                child: Text(state.errorMessage),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
