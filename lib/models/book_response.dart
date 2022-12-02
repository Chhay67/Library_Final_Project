class BookResponse {
  Data? _data;

  BookResponse({Data? data}) {
    if (data != null) {
      _data = data;
    }
  }

  Data? get data => _data;
  set data(Data? data) => _data = data;

  BookResponse.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_data != null) {
      data['data'] = _data!.toJson();
    }
    return data;
  }
}

class Data {
  int? _id;
  AttrBookResponse? _attributes;

  Data({int? id, AttrBookResponse? attributes}) {
    if (id != null) {
      _id = id;
    }
    if (attributes != null) {
      _attributes = attributes;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  AttrBookResponse? get attributes => _attributes;
  set attributes(AttrBookResponse? attributes) => _attributes = attributes;

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _attributes = json['attributes'] != null
        ? AttrBookResponse.fromJson(json['attributes'])
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

class AttrBookResponse {
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
  int? _authorId;
  String? _authorName;
  int? _imageId;

  AttrBookResponse(
      {String? code,
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
        int? authorId,
        String? authorName,
        int? imageId}) {
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
    if( authorId != null){
      _authorId = authorId;
    }
    if(authorName != null)
      {
        _authorName = authorName;
      }
    if( imageId != null){
      _imageId = imageId;
    }
  }
  int? get authorId => _authorId;
  set authorId(int? authorId) => _authorId =authorId;
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
  String? get authorName => _authorName;
  set authorName(String? authorName) => _authorName = authorName;
  int? get imageId => _imageId;
  set imageId(int? imageId) => _imageId = imageId;

  AttrBookResponse.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
