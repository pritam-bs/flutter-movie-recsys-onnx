import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_list/api/api_provider.dart';
import 'package:flutter_movie_list/model/movie.dart';
import 'package:flutter_movie_list/onnx/ms_marco_mini_LmL6V3.dart';
import 'package:flutter_movie_list/repository/movie_repository.dart';
import 'package:flutter_movie_list/routes/routes.gr.dart';
import 'package:flutter_movie_list/screens/widget/poster_carousel.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Section {
  original,
  sorted,
}

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Movie> _movies = [];
  List<Movie> _sortedMovies = [];
  final movieType = PosterType.upcoming;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await _loadMovies();
        await _sortMoviesByRating(_movies);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            switch (Section.values[index]) {
              case Section.original:
                return PosterCarouselWidget(
                  movies: _movies,
                  name: movieType.name,
                );
              case Section.sorted:
                return PosterCarouselWidget(
                  movies: _sortedMovies,
                  name: movieType.name,
                );
              default:
                throw UnimplementedError();
            }
          },
          itemCount: Section.values.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        ),
      ),
    );
  }

  Future<void> _loadMovies() async {
    final _repository = MovieRepository(apiProvider: ApiProviderImpl());
    late List<Movie> movies;

    if (movieType == PosterType.popular) {
      final result = await _repository.getPopular();
      movies = result.results;
    } else if (movieType == PosterType.upcoming) {
      final result = await _repository.getUpcoming();
      movies = result.results;
    } else {
      //do nothing
      movies = [];
    }

    setState(() {
      _movies = movies;
    });
  }

  Future<void> _sortMoviesByRating(List<Movie> movies) async {
    final prefs = await SharedPreferences.getInstance();
    final descriptionText = prefs.getString('descriptionText');
    if (descriptionText == null) {
      setState(() {
        _sortedMovies = movies;
      });
      return;
    }
    final _msmarcoMiniLmL6V3 = MsmarcoMiniLmL6V3();
    await _msmarcoMiniLmL6V3.initModel();
    final descriptionEmbeddings =
        await _msmarcoMiniLmL6V3.getEmbeddings(descriptionText);

    if (descriptionEmbeddings == null) {
      setState(() {
        _sortedMovies = movies;
      });
      return;
    }

    var scores = <Map<String, dynamic>>[];
    for (var movie in movies) {
      final movieDescription = movie.description;
      final movieDescriptionEmbeddings =
          await _msmarcoMiniLmL6V3.getEmbeddings(movieDescription);
      if (movieDescriptionEmbeddings != null) {
        final similarity = _msmarcoMiniLmL6V3.cosineSimilarity(
          movieDescriptionEmbeddings,
          descriptionEmbeddings,
        );
        scores.add({'movieIndex': movies.indexOf(movie), 'score': similarity});
      } else {
        scores.add({'movieIndex': movies.indexOf(movie), 'score': 0.0});
      }
    }

    // Sort movies based on scores
    scores
        .sort((a, b) => (b['score'] as double).compareTo(a['score'] as double));

    // Reorder the original list based on sorted scores
    var sortedMovies = <Movie>[];
    for (var i = 0; i < movies.length; i++) {
      final movieIndex = scores[i]['movieIndex'] as int;
      sortedMovies.add(movies[movieIndex]);
    }

    _msmarcoMiniLmL6V3.release();

    setState(() {
      _sortedMovies = sortedMovies;
    });
  }
}

enum PosterType {
  popular,
  upcoming,
}

extension on PosterType {
  String get name {
    switch (this) {
      case PosterType.popular:
        return 'Popular';
      case PosterType.upcoming:
        return 'Upcoming';
    }
  }
}
