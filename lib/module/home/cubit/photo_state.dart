
import '../model/photos_model.dart';

enum PhotoStatus {
  loading,
  failed,
  success,
}

class PhotoState {
  final PhotoStatus photoStatus;
  final String message;
  final List<PhotosModel> photos;

  PhotoState(
      {required this.photoStatus, required this.message, required this.photos});

  factory PhotoState.loading() {
    return PhotoState(
        photoStatus: PhotoStatus.loading, message: '', photos: []);
  }

  /*factory PhotoState.success(List<PhotosModel> photos) {
    return PhotoState(
      photoStatus: PhotoStatus.success,
      message: '',
      photos: photos,
    );
  }*/

  PhotoState copyWith({
    PhotoStatus? photoStatus, String? message, List<PhotosModel>? photos}) {
    return PhotoState(
        photoStatus: photoStatus ?? this.photoStatus,
        message: message ?? this.message,
        photos: photos ?? this.photos);
  }
}
