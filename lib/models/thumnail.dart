class Thumbnail {
  Data? _data;

  Thumbnail({Data? data}) {
    if (data != null) {
      _data = data;
    }
  }

  Data? get data => _data;
  set data(Data? data) => _data = data;

  Thumbnail.fromJson(Map<String, dynamic> json) {
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
  String? _url;

  Attributes({String? name, String? url}) {
    if (name != null) {
      _name = name;
    }
    if (url != null) {
      _url = url;
    }
  }

  String? get name => _name;
  set name(String? name) => _name = name;
  String? get url => _url;
  set url(String? url) => _url = url;

  Attributes.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _url = "https://cms.istad.co${json['url']}";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = _name;
    data['url'] = _url;
    return data;
  }
}
