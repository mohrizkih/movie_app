import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/blocs/search_movie/search_movie_bloc.dart';

import 'search_card.dart';

class CustomSearchDelegate extends SearchDelegate {
  final SearchMovieBloc searchMovieBloc;

  CustomSearchDelegate(this.searchMovieBloc);

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
      child: Icon(
        Icons.arrow_back,
        color: Colors.white,
        size: 14,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchMovieBloc.add(SearchQueryChangedEvent(query, 1));
    return BlocBuilder<SearchMovieBloc, SearchMovieState>(
        bloc: searchMovieBloc,
        builder: (context, state) {
          if (state is SearchMovieError) {
            print('error\nerrorerror\nerrorerror\nerrorerror\nerror');
            return Container();
          } else if (state is SearchMovieLoaded) {
            final movies = state.movieResultEntity.movies;
            if (movies.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 64),
                  child: Text(
                    'TranslationConstants.noMoviesSearched.t(context)',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) => SearchMovieCard(
                movie: movies[index],
              ),
              itemCount: movies.length,
              scrollDirection: Axis.vertical,
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
