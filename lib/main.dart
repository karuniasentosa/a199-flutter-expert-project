import 'package:core/common/app_colors.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart' show PopularTvSeriesPage, TvSeriesDetailPage;
import 'package:movie/pages.dart' show PopularMoviesPage, MovieDetailPage, TopRatedMoviesPage;
import 'package:movie/blocs.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:ditonton/presentation/provider/tv_series/popular_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_watchlist_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<NowPlayingMoviesCubit>(
          create: (_) => di.locator<NowPlayingMoviesCubit>(),
        ),
        BlocProvider<TopRatedMoviesCubit>(
          create: (_) => di.locator<TopRatedMoviesCubit>(),
        ),
        BlocProvider<PopularMoviesCubit>(
          create: (_) => di.locator<PopularMoviesCubit>(),
        ),
        BlocProvider<MovieDetailCubit>(
          create: (_) => di.locator<MovieDetailCubit>()
        ),
        BlocProvider<MovieWatchlistBloc>(
          create: (_) => di.locator<MovieWatchlistBloc>()
        ),
        BlocProvider<SearchMoviesCubit>(
          create: (_) => di.locator<SearchMoviesCubit>()
        ),
        BlocProvider<WatchlistMoviesCubit>(
          create: (_) => di.locator<WatchlistMoviesCubit>()
        ),

        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesDetailNotifier>(),
        ),
        ChangeNotifierProvider(
            create: (_) => di.locator<TvSeriesSearchNotifier>()
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesWatchlistNotifier>()
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: AppColors.kRichBlack,
          accentColor: AppColors.kMikadoYellow,
          scaffoldBackgroundColor: AppColors.kRichBlack,
          textTheme: kTextTheme,
          dividerTheme: kDividerTheme,
        ),
        home: HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case PopularTvSeriesPage.routeName:
              return MaterialPageRoute(builder: (_) => PopularTvSeriesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TvSeriesDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => TvSeriesDetailPage(tvSeriesId: id),
                  settings: settings
              );
            case SearchPage.ROUTE_NAME:
              final searchContext = settings.arguments as SearchContext;
              return CupertinoPageRoute(
                  builder: (_) => SearchPage(searchContext),
                  settings: settings
              );
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
