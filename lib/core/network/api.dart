import 'package:dio/dio.dart';

class API {
  final Dio _dio = Dio();
  static String apiKey = 'CBBR72I46eDKpuPbYcyelTdHnUo4mIKpjINI5gRhwmPJ5M622DsjXjVg';


  //final token=await AuthHelper.getAuthToken();
  API() {
    _dio.options.baseUrl = "https://api.pexels.com/v1";
    _dio.options.headers["authorization"] = apiKey;
    _dio.interceptors.add(
        LogInterceptor(requestHeader: true, requestBody: true, request: true));
  }

  Dio get sentRequest => _dio;

}

//Pixel API key
//CBBR72I46eDKpuPbYcyelTdHnUo4mIKpjINI5gRhwmPJ5M622DsjXjVg
///curated?per_page=10&page=1