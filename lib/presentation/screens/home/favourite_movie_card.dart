import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/image_url.dart';
import 'package:movie_app/data/core/api-constants.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/presentation/blocs/favourite_movie/favourite_movie_bloc.dart';

class FavouriteMovieCard extends StatelessWidget {
  const FavouriteMovieCard({Key? key, required this.movie}) : super(key: key);
  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.4,
      height: width * 0.55,
      padding: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            movie.posterPath == ''
                ? Image.asset(
                    imagePlaceholder,
                    fit: BoxFit.contain,
                  )
                : Image.network('${ApiConstant.BASE_IMAGE_URL185}${movie.posterPath}',
                    fit: BoxFit.cover, width: double.infinity, height: width * 0.55),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  BlocProvider.of<FavouriteMovieBloc>(context).add(
                    DeleteFavouriteMovieEvent(movie.id),
                  );
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.green.shade600,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                color: Colors.white.withOpacity(0.5),
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                child: Text(
                  movie.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
