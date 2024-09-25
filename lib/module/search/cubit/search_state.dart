import 'package:wall_app/module/search/model/search_model.dart';

enum SearchStatus {initial, loading, success, failed }

class SearchState {
  final SearchStatus searchStatus;
  final String message;
  final List<SearchModel> search;

  SearchState(
      {required this.searchStatus,
      required this.message,
      required this.search});

  factory SearchState.initial() {
    return SearchState(
        searchStatus: SearchStatus.initial, message: '', search: []);
  }

  SearchState copyWith(
      {SearchStatus? searchStatus,
      String? message,
      List<SearchModel>? search}) {
    return SearchState(
        searchStatus: searchStatus ?? this.searchStatus,
        message: message ?? this.message,
        search: search ?? this.search);
  }
}
