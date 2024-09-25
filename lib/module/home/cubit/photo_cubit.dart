import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_app/module/home/cubit/photo_state.dart';
import 'package:wall_app/repository/photos_repo.dart';

import '../model/photos_model.dart';

class PhotoCubit extends Cubit<PhotoState> {
  final PhotosRepo photosRepo;

  PhotoCubit(this.photosRepo) : super(PhotoState.loading()) {
    getPhotos();
  }
  int page=0;
  Future<void> getPhotos() async {
    try {
      List<PhotosModel> newPhotos = await photosRepo.getPhoto(page: page + 1, perPage: 10);
      List<PhotosModel> updatedPhotos = List.from(state.photos)..addAll(newPhotos);

      emit(state.copyWith(
        photoStatus: PhotoStatus.success,
        photos: updatedPhotos,
      ));

      page = page + 1;
    } catch (ex) {
      emit(state.copyWith(photoStatus: PhotoStatus.failed,message: ex.toString()));
    }
    print(page);
  }
}
