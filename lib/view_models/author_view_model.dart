import 'package:flutter/cupertino.dart';
import '../data/response/api_response.dart';
import '../models/author.dart';
import '../models/author_model.dart';
import '../models/image_response.dart';
import '../repository/author_repository.dart';


class AuthorViewModel extends ChangeNotifier{
  final _authorRepository = AuthorRepository();
  ApiResponse<AuthorModel> authorList = ApiResponse.loading();
  ApiResponse<ImageModel> imageResponse = ApiResponse.loading();
  ApiResponse<Author> authorResponse = ApiResponse.loading();

  setAuthorList(ApiResponse<AuthorModel> response){
    authorList = response;
    notifyListeners();
  }

  setAuthorResponse(ApiResponse<Author> response){
    authorResponse = response;
    notifyListeners();
  }


  Future<dynamic> fetchAllAuthor() async{
    await _authorRepository.getAuthor().then((value){
      setAuthorList(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setAuthorList(ApiResponse.error(error.toString()));
    });
  }

  Future<dynamic> postAuthor(data,imageId)async{
    await _authorRepository.postAuthor(data, imageId).then((value){
      setAuthorResponse(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setAuthorResponse(ApiResponse.error(error.toString()));
    });
  }

  Future<dynamic> putAuthor(data,authorId,imageId) async{
    await _authorRepository.putAuthor(data, authorId, imageId).then((value) {
      setAuthorResponse(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setAuthorResponse(ApiResponse.error(error.toString()));
    });
  }
  Future<dynamic> deleteAuthor(authorId) async{
    await _authorRepository.deleteAuthor(authorId).then((value) {
      setAuthorResponse(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setAuthorResponse(ApiResponse.error(error.toString()));
    });
  }
  bool isLoading;
  AuthorViewModel({this.isLoading = false});
  void toggleLoadingStatus ()
  {
    isLoading = !isLoading;
    notifyListeners();
  }

}