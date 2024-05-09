import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_list/model/movie.dart';
import 'package:flutter_movie_list/routes/routes.gr.dart';

class PosterCarouselWidget extends StatefulWidget {
  const PosterCarouselWidget({
    required this.movies,
    required this.name,
    Key? key,
  }) : super(key: key);

  final List<Movie> movies;
  final String name;

  @override
  State<PosterCarouselWidget> createState() => _PosterCarouselWidgetState();
}

class _PosterCarouselWidgetState extends State<PosterCarouselWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            widget.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 300,
          ),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: widget.movies.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: _PosterTile(
                    movie: widget.movies[index],
                  ),
                );
              }

              return _PosterTile(
                movie: widget.movies[index],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 20,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PosterTile extends StatelessWidget {
  const _PosterTile({
    required this.movie,
    Key? key,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                fit: BoxFit.fitHeight,
                height: 230,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              movie.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      onTap: () => AutoRouter.of(context).push(MovieDetailsRoute(movie: movie)),
    );
  }
}
