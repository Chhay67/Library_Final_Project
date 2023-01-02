import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:library_final_project/models/author.dart';
import '../../models/image_response.dart';
import '../app_exception.dart';
import '../../models/book_response.dart';
class NetworkApiService {
  dynamic responseJson;
  Future<dynamic> getAll(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      responseJson = returnJsonResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection');
    }
    return responseJson;
  }
  Future uploadImage(String url, File file) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('files', file.path));

    var response = await request.send();

    var resource = await response.stream.bytesToString();

    var decode = json.decode(resource);

    List<ImageModel> imageResponse = List<ImageModel>.from(
        decode.map((imageModel) => ImageModel.fromJson(imageModel)));
    return imageResponse.first.toJson();
  }
  Future getImage(String url , int? imageId) async{
    var request = http.Request('GET', Uri.parse('$url/$imageId'));

    var response = await request.send();

    var resource = await response.stream.bytesToString();

    return json.decode(resource);

  }

  Future postBook(String url,dynamic data ,int? imageId ) async{
    AttrBookResponse? bookData = data;
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({
      "data": {
        "code": "${bookData?.code}",
        "title": "${bookData?.title}",
        "description": "${bookData?.description}",
        "price": bookData?.price,
        "star_review": bookData?.starReview,
        "originally_published": "${bookData?.originallyPublished}",
        "ib_author":bookData?.authorId == null ? "38": "${bookData?.authorId}",
        "pdf_link": "none",
        "isEnabled": true,
        "thumbnail": "$imageId"
      }
    });
    request.headers.addAll(headers);

    var response = await request.send();
    var resource = await response.stream.bytesToString();

    return json.decode(resource);
  }
  Future putBook(String url,dynamic data,int bookId ,int? imageId) async{
    AttrBookResponse? bookData = data;
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT', Uri.parse('$url/$bookId'));
    request.body = json.encode({
      "data": {
        "code": "${bookData?.code}",
        "title": "${bookData?.title}",
        "description": "${bookData?.description}",
        "price": bookData?.price,
        "star_review": bookData?.starReview,
        "originally_published": "${bookData?.originallyPublished}",
        "ib_author": bookData?.authorId == null ? "38": "${bookData?.authorId}",
        "pdf_link": "none",
        "isEnabled": true,
        "thumbnail": "$imageId"
      }
    });
    request.headers.addAll(headers);

    var response = await request.send();
    var resource = await response.stream.bytesToString();
    return json.decode(resource);
  }

  Future deleteById(String url,int id) async{
    var request = http.Request('DELETE', Uri.parse('$url/$id'));
    var response = await request.send();
    var resource = await response.stream.bytesToString();
    return json.decode(resource);
  }

  Future postAuthor (String url ,dynamic data,int? imageId)async{
    Attributes authorData = data;
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({
      "data": {
        "name": "${authorData.name}",
        "short_biography": "${authorData.shortBiography}",
        "photo": "$imageId"
      }
    });
    request.headers.addAll(headers);

    var response = await request.send();
    var resource = await response.stream.bytesToString();

    return json.decode(resource);
  }
  Future putAuthor(String url,dynamic data,int authorId,int? imageId) async{
    Attributes authorData = data;
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT', Uri.parse('$url/$authorId'));
    request.body = json.encode({
      "data": {
        "name": "${authorData.name}",
        "short_biography": "${authorData.shortBiography}",
        "photo": "$imageId"
      }
    });
    request.headers.addAll(headers);

    var response = await request.send();
    var resource = await response.stream.bytesToString();

    return json.decode(resource);
  }
}

dynamic returnJsonResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      return jsonDecode(response.body);

    case 400:
      throw BadRequestException(response.body.toString());

    case 401:
      throw UnAuthorizedException(response.body.toString());

    default:
      throw FetchDataException('unexpected error occurred');
  }
}
