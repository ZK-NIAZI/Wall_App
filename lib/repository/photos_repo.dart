import 'package:dio/dio.dart';
import 'package:wall_app/module/search/model/search_model.dart';

import '../core/network/api.dart';
import '../module/home/model/photos_model.dart';

class PhotosRepo {
  API api = API();

  Future<List<PhotosModel>> getPhoto(
      {required int page, required int perPage}) async {
    try {
      Response response = await api.sentRequest.get('/curated',
          queryParameters: {'page': page, 'per_page': perPage});
      return List.from(response.data['photos'])
          .map((photos) => PhotosModel.fromJson(photos))
          .toList();
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
  Future<List<SearchModel>> getSearchPhoto(
      {required int page, required int perPage,required String query}) async {
    try {
      Response response = await api.sentRequest.get('/search',
          queryParameters: {'page': page, 'per_page': perPage,'query':query});
      return List.from(response.data['photos'])
          .map((photos) => SearchModel.fromJson(photos))
          .toList();
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
