import 'package:flutter/material.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';

import 'favourite_movie_card.dart';

class ListFavouriteMovieScreen extends StatelessWidget {
  ListFavouriteMovieScreen({Key? key, required this.listMovies}) : super(key: key);
  final List<MovieEntity> listMovies;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.fromLTRB(0, 12, 0, 80),
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        runSpacing: 12,
        spacing: 6,
        children: listMovies.map((e) => FavouriteMovieCard(movie: e)).toList(),
      ),
    );
  }
}
