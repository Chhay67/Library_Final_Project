import '../data/network/network_api_service.dart';
import '../models/image_response.dart';
import '../res/app_url.dart';

class ImageRepository{
  final NetworkApiService _apiService = NetworkApiService();

  Future<ImageModel> uploadImage(file)async{
    try{
      var response = await _apiService.uploadImage(AppUrl.uploadImage, file);
      return response = ImageModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }
}