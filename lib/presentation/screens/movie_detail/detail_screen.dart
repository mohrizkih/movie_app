import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/core/api-constants.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/presentation/blocs/favourite_movie/favourite_movie_bloc.dart';
import 'package:movie_app/presentation/widgets/collapsed_info.dart';
import 'package:movie_app/presentation/widgets/my_leading.dart';
import 'package:movie_app/presentation/widgets/release_date.dart';

import '../../../injection_container.dart';

part 'app_bar_movie_detail.dart';

class DetailMovie extends StatefulWidget {
  const DetailMovie({Key? key, required this.movieEntity}) : super(key: key);
  final MovieEntity movieEntity;

  @override
  _DetailMovieState createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  bool isCollapsed = true;

  late FavouriteMovieBloc favouriteMovieBloc;

  @override
  void initState() {
    favouriteMovieBloc = getItInstance<FavouriteMovieBloc>();
    favouriteMovieBloc.add(CheckIfFavoriteMovieEvent(widget.movieEntity.id));
    super.initState();
  }

  @override
  void dispose() {
    favouriteMovieBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => favouriteMovieBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarMovieDetail(
          widget: widget,
          favouriteMovieBloc: favouriteMovieBloc,
        ),
        body: Stack(
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    isCollapsed = true;
                  });
                },
                child: Container(
                    width: double.infinity,
                    child: widget.movieEntity.posterPath != ''
                        ? Image.network(
                            '${ApiConstant.BASE_IMAGE_URL500}${widget.movieEntity.posterPath}',
                            fit: BoxFit.cover)
                        : Container())),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isCollapsed == true ? isCollapsed = false : isCollapsed = true;
                  });
                },
                child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                      color: Colors.white,
                    ),
                    height: isCollapsed ? 120 : 450,
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CollapsedInformation(
                                title: widget.movieEntity.title,
                                overview: widget.movieEntity.overview ?? '',
                              ),
                              if (!isCollapsed) ...[
                                OtherDescription(
                                  iconData: Icons.access_time_outlined,
                                  title: 'Release Date',
                                  description: widget.movieEntity.releaseDate,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                OtherDescription(
                                  iconData: Icons.grade_sharp,
                                  title: 'Average Vote',
                                  description: widget.movieEntity.voteAverage.toString(),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ]
                            ],
                          ),
                        ))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
