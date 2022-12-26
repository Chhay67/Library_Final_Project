import 'package:flutter/material.dart';
import 'package:library_final_project/models/book_response.dart';
import 'package:library_final_project/models/image_response.dart';
import '../data/response/api_response.dart';
import '../models/book.dart';
import '../repository/book_repository.dart';

class BookViewModel extends ChangeNotifier{
  final _bookRepository = BookRepository();

  ApiResponse<BookModel> bookList = ApiResponse.loading();
  ApiResponse<ImageModel> imageResponse = ApiResponse.loading();
  ApiResponse<BookResponse> bookResponse = ApiResponse.loading();


  setBookResponse(ApiResponse<BookResponse> response)
  {
    bookResponse = response;
    print('bookViewModel : $bookResponse');
    notifyListeners();
  }

  setBookList(ApiResponse<BookModel> response){
    bookList = response;
    notifyListeners();
  }

  Future<dynamic> fetchAllBooks() async{
    await _bookRepository.getBook().then((value){
      setBookList(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setBookList(ApiResponse.error(error.toString()));
    });
  }

  Future<dynamic> postBook (data, imageId) async{
    await _bookRepository.postBook(data, imageId).then((value) {
      setBookResponse(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setBookResponse(ApiResponse.error(error.toString()));
    });
  }
  Future<dynamic> putBook(data,bookId,imageId) async{
    await _bookRepository.putBook(data, bookId, imageId).then((value) {
      print('bookViewModel 1: $value}');
      setBookResponse(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setBookResponse(ApiResponse.error(error.toString()));
    });
  }
  Future<dynamic> deleteBook(bookId) async{
    await _bookRepository.deleteBook(bookId).then((value) {
      setBookResponse(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setBookResponse(ApiResponse.error(error.toString()));
    });
  }
  bool isLoading;
  BookViewModel({this.isLoading = false});
  void toggleLoadingStatus ()
  {
    isLoading = !isLoading;
    notifyListeners();
  }



}