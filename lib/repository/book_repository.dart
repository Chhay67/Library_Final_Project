import 'package:library_final_project/models/book_response.dart';
import 'package:library_final_project/models/image_response.dart';

import '../res/app_url.dart';
import '../data/network/network_api_service.dart';
import '../models/book.dart';

class BookRepository{
  final NetworkApiService _apiService = NetworkApiService();
  Future<BookModel> getBook ()async{
    try{
      var response = await _apiService.getAll(AppUrl.getBooks);
      return response = BookModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<BookResponse> postBook(data,imageId) async{
    try{
      dynamic response = await _apiService.postBook(AppUrl.postBook, data, imageId);
      return response = BookResponse.fromJson(response);
    }catch(e) {
      rethrow;
    }
  }
  Future<BookResponse> putBook(data,bookId,imageId) async{
    try{
      dynamic response = await _apiService.putBook(AppUrl.postBook, data, bookId, imageId);
      return response = BookResponse.fromJson(response);
    }catch(e){
      rethrow;
    }
  }
  Future<BookResponse> deleteBook(bookId) async{
    try{
      dynamic response = await _apiService.deleteById(AppUrl.postBook, bookId);
      return response = BookResponse.fromJson(response);
    }catch(e){
      rethrow;
    }
  }


  Future<ImageModel> uploadImage(file)async{
    try{
      var response = await _apiService.uploadImage(AppUrl.uploadImage, file);
      print('repo $response');
      return response = ImageModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }
}