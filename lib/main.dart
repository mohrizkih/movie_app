import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/data/table/movie_table.dart';
import 'package:movie_app/presentation/screens/home/home_screen.dart';
import 'package:pedantic/pedantic.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'injection_container.dart' as getIt;

void main() async {
  unawaited(getIt.init());
  WidgetsFlutterBinding.ensureInitialized();

  final documentDirectory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(documentDirectory.path);
  Hive.registerAdapter(MovieTableAdapter());

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(),
    );
  }
}
