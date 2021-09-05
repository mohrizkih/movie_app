import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:movie_app/presentation/widgets/my_leading.dart';

import 'search_card.dart';

class CustomSearchDelegate extends SearchDelegate {
  final SearchMovieBloc searchMovieBloc;

  CustomSearchDelegate(this.searchMovieBloc);
  int page = 1;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: query.isEmpty ? null : () => query = '',
        icon: Icon(
          Icons.clear,
          color: query.isEmpty ? Colors.grey : Colors.indigo,
        ),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: () {
        close(context, null);
      },
      child: MyLeading(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchMovieBloc.add(SearchQueryChangedEvent(query, page));
    return BlocBuilder<SearchMovieBloc, SearchMovieState>(
        bloc: searchMovieBloc,
        builder: (context, state) {
          if (state is SearchMovieError) {
            print('error\nerrorerror\nerrorerror\nerrorerror\nerror');
            return Container();
          } else if (state is SearchMovieLoaded) {
            final movies = state.movieResultEntity.movies;
            final currentPage = state.movieResultEntity.page;
            final totalPage = state.movieResultEntity.totalPages;
            if (movies.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 64),
                  child: Text(
                    'No Movies Found',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    // shrinkWrap: true,
                    itemBuilder: (context, index) => SearchMovieCard(
                      movie: movies[index],
                    ),
                    itemCount: movies.length,
                    scrollDirection: Axis.vertical,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: currentPage == 1
                            ? null
                            : () {
                                page--;
                                searchMovieBloc.add(SearchQueryChangedEvent(query, page));
                              },
                        child: Text('Previous')),
                    Text('$currentPage from $totalPage pages'),
                    ElevatedButton(
                        onPressed: currentPage == totalPage
                            ? null
                            : () {
                                page++;
                                searchMovieBloc.add(SearchQueryChangedEvent(query, page));
                              },
                        child: Text('Next'))
                  ],
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SizedBox.shrink();
  }
}
