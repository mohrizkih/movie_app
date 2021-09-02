import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/domain/entities/movie_result_entity.dart';
import 'package:movie_app/domain/entities/search_params.dart';
import 'package:movie_app/domain/usecases/search_movies.dart';
import 'package:movie_app/presentation/screens/home/home_screen.dart';
import 'package:pedantic/pedantic.dart';

import 'domain/entities/app_error.dart';
import 'injection_container.dart' as getIt;

void main() {
  unawaited(getIt.init());
  WidgetsFlutterBinding.ensureInitialized();

  // SearchMovies searchMovies = getIt.getItInstance<SearchMovies>();
  // final Either<AppError, MovieResultEntity> either =
  //     await searchMovies(SearchParams('Spiderman', 1));
  // either.fold((l) {
  //   print(l);
  //   print('error');
  // }, (r) {
  //   print('movies result');
  //   print(r);
  // });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // appBarTheme: AppBarTheme(elevation: 0),
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
