

class Author {
  Data? _data;

  Author({Data? data}) {
    if (data != null) {
      _data = data;
    }
  }

  Data? get data => _data;
  set data(Data? data) => _data = data;

  Author.fromJson(Map<String, dynamic> json) {
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
  Attributes? _attributes;

  Data({int? id, Attributes? attributes}) {
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

  Data.fromJson(Map<String, dynamic> json) {
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
  String? _name;
  String? _shortBiography;
  String? _createdAt;
  String? _updatedAt;

  Attributes(
      {String? name,
        String? shortBiography,
        String? createdAt,
        String? updatedAt,
        }) {
    if (name != null) {
      _name = name;
    }
    if (shortBiography != null) {
      _shortBiography = shortBiography;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }

  }

  String? get name => _name;
  set name(String? name) => _name = name;
  String? get shortBiography => _shortBiography;
  set shortBiography(String? shortBiography) =>
      _shortBiography = shortBiography;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;


  Attributes.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _shortBiography = json['short_biography'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = _name;
    data['short_biography'] = _shortBiography;
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;

    return data;
  }
}
