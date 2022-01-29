import 'package:mockito/annotations.dart';
import 'package:movie/usecases.dart';

@GenerateMocks(
    [ GetTopRatedMovies, GetPopularMovies,
      GetNowPlayingMovies, SearchMovies,
      SaveWatchlist, RemoveWatchlist,
      GetWatchListStatus, GetMovieDetail,
      GetMovieRecommendations, GetWatchlistMovies,
    ]
)
void main(){}