import 'package:flutter/material.dart';
import '../data/response/api_response.dart';
import '../models/image_response.dart';
import '../repository/image_repository.dart';

class ImageViewModel extends ChangeNotifier{
  final _imageRepository = ImageRepository();

  ApiResponse<ImageModel> imageResponse = ApiResponse.loading();

  setImageResponse(ApiResponse<ImageModel> response){
    imageResponse = response;
    print('imageViewModel $imageResponse');
    notifyListeners();
  }
  Future<dynamic> uploadImage(file) async{
    await _imageRepository.uploadImage(file).then((value) {
      print('imageViewModel1 $value');
      setImageResponse(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setImageResponse(ApiResponse.error(error.toString()));
    });
  }
}