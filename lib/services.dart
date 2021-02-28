import 'package:dio/dio.dart';

class PhotosApi {
  Response response;
  Dio dio = new Dio();

  getPhotos(int page, String search) async {
    response = await dio.get("https://api.pexels.com/v1/search?query=$search&per_page=10&page=$page",
        options: Options(headers: {'Authorization': 'Bearer 563492ad6f917000010000014c57db80b889482f9cc574a83800894e'}));
    print(response.data);
    return response.data;
  }
}
