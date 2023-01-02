class AppUrl{
  static String baseUrl = 'https://cms.istad.co';
  static String getBooks = '$baseUrl/api/ib-books?populate=%2A';
  static String uploadImage = '$baseUrl/api/upload';
  static String getImage = '$baseUrl/api/upload/files';
  static String postBook = '$baseUrl/api/ib-books';
  static String getAuthors = '$baseUrl/api/ib-authors?populate=%2A';
  static String postAuthor = '$baseUrl/api/ib-authors';
}