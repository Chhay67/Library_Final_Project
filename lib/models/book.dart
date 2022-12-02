import 'author.dart';
import 'thumnail.dart';

class BookModel {
  List<BookData>? _data;

  BookModel({List<BookData>? data}) {
    if (data != null) {
      _data = data;
    }
  }

  List<BookData>? get data => _data;
  set data(List<BookData>? data) => _data = data;

  BookModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <BookData>[];
      json['data'].forEach((v) {
        _data!.add(BookData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_data != null) {
      data['data'] = _data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookData {
  int? _id;
  Attributes? _attributes;

  BookData({int? id, Attributes? attributes}) {
    if (id != null) {
      _id = id;
    }
    if (attributes != null) {
      _attributes = attributes;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  Attributes? get attributes => _attributes;
  set attributes(Attributes? attributes) => _attributes = attributes;

  BookData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _attributes = json['attributes'] != null
        ? Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    if (_attributes != null) {
      data['attributes'] = _attributes!.toJson();
    }
    return data;
  }
}

class Attributes {
  String? _code;
  String? _title;
  String? _description;
  String? _createdAt;
  String? _updatedAt;
  String? _publishedAt;
  int? _price;
  int? _starReview;
  String? _originallyPublished;
  String? _pdfLink;
  bool? _isEnabled;
  Author? _author;
  Thumbnail? _thumbnail;

  Attributes({
    String? code,
    String? title,
    String? description,
    String? createdAt,
    String? updatedAt,
    String? publishedAt,
    int? price,
    int? starReview,
    String? originallyPublished,
    String? pdfLink,
    bool? isEnabled,
    Author? author,
    Thumbnail? thumbnail,
  }) {
    if (code != null) {
      _code = code;
    }
    if (title != null) {
      _title = title;
    }
    if (description != null) {
      _description = description;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
    if (publishedAt != null) {
      _publishedAt = publishedAt;
    }
    if (price != null) {
      _price = price;
    }
    if (starReview != null) {
      _starReview = starReview;
    }
    if (originallyPublished != null) {
      _originallyPublished = originallyPublished;
    }
    if (pdfLink != null) {
      _pdfLink = pdfLink;
    }
    if (isEnabled != null) {
      _isEnabled = isEnabled;
    }
    if(author != null)
      {
        _author = author;
      }
    if(thumbnail != null)
      {
        _thumbnail = thumnail;
      }
  }

  String? get code => _code;
  set code(String? code) => _code = code;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  String? get publishedAt => _publishedAt;
  set publishedAt(String? publishedAt) => _publishedAt = publishedAt;
  int? get price => _price;
  set price(int? price) => _price = price;
  int? get starReview => _starReview;
  set starReview(int? starReview) => _starReview = starReview;
  String? get originallyPublished => _originallyPublished;
  set originallyPublished(String? originallyPublished) =>
      _originallyPublished = originallyPublished;
  String? get pdfLink => _pdfLink;
  set pdfLink(String? pdfLink) => _pdfLink = pdfLink;
  bool? get isEnabled => _isEnabled;
  set isEnabled(bool? isEnabled) => _isEnabled = isEnabled;
  Author? get author => _author;
  set author(Author? author) => _author = author;
  Thumbnail? get thumnail => _thumbnail;
  set thumbnail(Thumbnail? thumbnail) => _thumbnail = thumbnail;

  Attributes.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _title = json['title'];
    _description = json['description'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _publishedAt = json['publishedAt'];
    _price = json['price'];
    _starReview = json['star_review'];
    _originallyPublished = json['originally_published'];
    _pdfLink = json['pdf_link'];
    _isEnabled = json['isEnabled'];
     _author = Author.fromJson(json['ib_author']);
    _thumbnail =Thumbnail.fromJson(json['thumbnail']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = _code;
    data['title'] = _title;
    data['description'] = _description;
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;
    data['publishedAt'] = _publishedAt;
    data['price'] = _price;
    data['star_review'] = _starReview;
    data['originally_published'] = _originallyPublished;
    data['pdf_link'] = _pdfLink;
    data['isEnabled'] = _isEnabled;
    data['ib_author'] = _author;
    data['thumbnail'] = _thumbnail;
    return data;
  }
}
