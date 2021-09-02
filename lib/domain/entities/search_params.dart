import 'package:equatable/equatable.dart';

class SearchParams extends Equatable {
  final String query;
  final int page;

  SearchParams(this.query, this.page);

  @override
  List<Object?> get props => [query, page];
}
