part of 'detail_screen.dart';

class AppBarMovieDetail extends StatefulWidget implements PreferredSizeWidget {
  AppBarMovieDetail({
    required this.widget,
    required this.favouriteMovieBloc,
  });

  final DetailMovie widget;
  final FavouriteMovieBloc favouriteMovieBloc;

  @override
  _AppBarMovieDetailState createState() => _AppBarMovieDetailState();

  @override
  final Size preferredSize = Size.fromHeight(kToolbarHeight);
}

class _AppBarMovieDetailState extends State<AppBarMovieDetail> {
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          widget.widget.movieEntity.title,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xff545454)),
        ),
        leading: MyLeading(),
        actions: [
          BlocBuilder<FavouriteMovieBloc, FavouriteMovieState>(
              bloc: BlocProvider.of<FavouriteMovieBloc>(context),
              builder: (context, state) {
                if (state is IsFavouriteMovie) {
                  return GestureDetector(
                      onTap: () {
                        print('oke');
                        BlocProvider.of<FavouriteMovieBloc>(context).add(ToggleFavouriteMovieEvent(
                          widget.widget.movieEntity,
                          state.isMovieFavourite,
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Icon(
                          state.isMovieFavourite ? Icons.favorite : Icons.favorite_outline,
                          color: Colors.pink,
                        ),
                      ));
                } else {
                  return GestureDetector(
                    onTap: () => print(state),
                    child: Icon(
                      Icons.favorite_outline,
                      color: Colors.pink,
                    ),
                  );
                }
              }),
        ]);
  }
}
