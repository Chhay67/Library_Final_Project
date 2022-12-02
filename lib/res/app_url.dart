class AppUrl{
  static String baseUrl = 'https://cms.istad.co/api';
  static String getBooks = '$baseUrl/ib-books?populate=%2A';
  static String uploadImage = '$baseUrl/upload';
  static String postBook = '$baseUrl/ib-books';
  static String getAuthors = '$baseUrl/ib-authors?populate=%2A';
  static String postAuthor = '$baseUrl/ib-authors';
}