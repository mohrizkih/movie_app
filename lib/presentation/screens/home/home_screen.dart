import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/injection_container.dart';
import 'package:movie_app/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:movie_app/presentation/screens/search_movies/search_movie_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SearchMovieBloc searchMovieBloc;
  late String searchQuery;
  late int page;

  @override
  void initState() {
    super.initState();

    searchMovieBloc = getItInstance<SearchMovieBloc>();
    // searchMovieBloc.noSuchMethod(invocation);
    // print(searchMovieBloc.searchMovies.movieRepository.getSearchMovie('spiderman', 1));
  }

  // @override
  // void dispose() {
  //   searchMovieBloc.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchMovieBloc>(
          create: (context) => searchMovieBloc,
          // lazy: false,
        ),
        // BlocProvider(
        //     create: (context) => SubjectBloc(),
        // ),
      ],
      child: BlocBuilder<SearchMovieBloc, SearchMovieState>(
        bloc: searchMovieBloc,
        builder: (context, state) {
          final searchBlocinstance = BlocProvider.of<SearchMovieBloc>(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("Rizki's Movie App"),
              actions: [
                IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(
                        searchMovieBloc,
                      ),
                    );
                  },
                  icon: Icon(Icons.search),
                ),
              ],
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
            ),
          );
        },
      ),
    );
  }
}
