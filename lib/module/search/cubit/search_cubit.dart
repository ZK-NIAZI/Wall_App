import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_app/module/search/cubit/search_state.dart';
import 'package:wall_app/module/search/model/search_model.dart';
import 'package:wall_app/repository/photos_repo.dart';

class SearchCubit extends Cubit<SearchState>{
  final PhotosRepo searchRepo;

  SearchCubit(this.searchRepo):super (SearchState.initial()){

  }

  int page=0;
  Future<void> getSearchPhotos(String query) async {
    emit(state.copyWith(searchStatus: SearchStatus.loading));
    try {
      List<SearchModel> newPhotos = await searchRepo.getSearchPhoto(page: page + 1, perPage: 30,query: query);
      List<SearchModel> updatedPhotos = List.from(state.search)..addAll(newPhotos);

      emit(state.copyWith(
        searchStatus: SearchStatus.success,
        search: updatedPhotos,
        message: query
      ));

      page = page + 1;
    } catch (ex) {
      emit(state.copyWith(searchStatus: SearchStatus.failed,message: ex.toString()));
    }
    print(page);
  }
}