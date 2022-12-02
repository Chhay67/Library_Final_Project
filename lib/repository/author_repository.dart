
import 'package:library_final_project/models/author_model.dart';
import '../models/author.dart';
import '../models/image_response.dart';
import '../res/app_url.dart';
import '../data/network/network_api_service.dart';

class AuthorRepository{
  final NetworkApiService _apiService = NetworkApiService();
  Future<AuthorModel> getAuthor ()async{
    try{
      var response = await _apiService.getAll(AppUrl.getAuthors);
      return  response = AuthorModel.fromJson(response);
    }catch(e)
    {
      rethrow;
    }
  }
  Future<Author> postAuthor(data,imageId) async{
    try{
      dynamic response = await _apiService.postAuthor(AppUrl.postAuthor, data, imageId);
      return response = Author.fromJson(response);
    }catch(e){
      rethrow;
    }
  }
  Future<Author> putAuthor(data,authorId,imageId) async{
    try{
      dynamic response = await _apiService.putAuthor(AppUrl.postAuthor, data, authorId, imageId);
      return response = Author.fromJson(response);
    }catch(e){
      rethrow;
    }
  }
  Future<Author> deleteAuthor(authorId)async{
    try{
      dynamic response = await _apiService.deleteById(AppUrl.postAuthor, authorId);
      return response =Author.fromJson(response);
    }catch(e){
      rethrow;
    }
  }


  Future<ImageModel> uploadImage(file)async{
    try{
      var response = await _apiService.uploadImage(AppUrl.uploadImage, file);
      return response = ImageModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }
}