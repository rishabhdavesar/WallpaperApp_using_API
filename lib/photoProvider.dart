import 'package:apicall_provider/model.dart';
import 'package:apicall_provider/services.dart';
import 'package:flutter/material.dart';

class PhotoProvider extends ChangeNotifier {
  int _page = 1;
  String _search = 'nature';

  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  int get page => _page;

  set page(int value) {
    _page = value;
    notifyListeners();
  }

  List<Photos> _photos = <Photos>[];

  List<Photos> get photos => _photos;

  set photos(List<Photos> value) {
    _photos = value;
  }

  Future<void> callPhotoApi() async {
    await PhotosApi().getPhotos(_page, _search).then((response) {
      _page = _page + 1;

      addPhotosToList(PhotoModel.fromJson(response).photos);
    });
    notifyListeners();
  }

  void addPhotosToList(List<Photos> photoData) {
    _photos.addAll(photoData);
    notifyListeners();
  }
}
