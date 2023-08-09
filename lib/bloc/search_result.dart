import 'package:flutter/foundation.dart';
import 'package:rxdart_practice/models/thing.dart';

@immutable
abstract class SearchResult {
  const SearchResult();
}

@immutable
class SearchResultLoading implements SearchResult {
  const SearchResultLoading();
}

@immutable
class SearchResultNotResult implements SearchResult {
  const SearchResultNotResult();
}

@immutable
class SearchResultHasError implements SearchResult {
  final Object error;
  const SearchResultHasError(this.error);
}

@immutable
class SearchResultWithResult implements SearchResult {
  final List<Thing> results;
  const SearchResultWithResult(this.results);
}
