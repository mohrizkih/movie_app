import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/injection_container.dart';
import 'package:movie_app/presentation/blocs/favourite_movie/favourite_movie_bloc.dart';
import 'package:movie_app/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:movie_app/presentation/screens/search_movies/search_movie_delegate.dart';

import 'list_favourite_movie_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SearchMovieBloc searchMovieBloc;
  late FavouriteMovieBloc favouriteMovieBloc;

  late String searchQuery;
  late int page;

  @override
  void initState() {
    super.initState();
    searchMovieBloc = getItInstance<SearchMovieBloc>();
    favouriteMovieBloc = getItInstance<FavouriteMovieBloc>();
    favouriteMovieBloc.add(LoadFavouriteMovieEvent());
  }

  @override
  void dispose() {
    searchMovieBloc.close();
    favouriteMovieBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchMovieBloc>(
          create: (context) => searchMovieBloc,
          // lazy: false,
        ),
        BlocProvider<FavouriteMovieBloc>(
          create: (context) => favouriteMovieBloc,
        ),
      ],
      child: BlocBuilder<FavouriteMovieBloc, FavouriteMovieState>(
        bloc: favouriteMovieBloc,
        builder: (context, state) {
          final searchBlocinstance = BlocProvider.of<SearchMovieBloc>(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Rizki's Movie App",
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(
                        searchMovieBloc,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        Text(
                          'Search',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: ElevatedButton(
              onPressed: () {
                favouriteMovieBloc.add(LoadFavouriteMovieEvent());
              },
              child: Text('Refresh'),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            body: Center(
              child: Column(
                children: [
                  if (state is FavouriteMovieLoaded) ...[
                    Text(
                      'My Favourite Movie',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    if (state.movies.isEmpty) ...[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'There is no favourite movie\nPlease add by search button below',
                              style: TextTheme().headline4,
                              textAlign: TextAlign.center,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                showSearch(
                                  context: context,
                                  delegate: CustomSearchDelegate(
                                    searchBlocinstance,
                                  ),
                                );
                              },
                              child: Text('Search'),
                            ),
                          ],
                        ),
                      ),
                    ],
                    Visibility(
                        visible: state.movies.isNotEmpty,
                        child: Expanded(
                            child: SingleChildScrollView(
                                child: ListFavouriteMovieScreen(listMovies: state.movies)))),
                    SizedBox(
                      height: 80,
                    ),
                  ] else ...[
                    SizedBox.shrink()
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
