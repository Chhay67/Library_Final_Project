import 'thumnail.dart';

class AuthorModel {
  List<DataAuthor>? data;

  AuthorModel({this.data});

  AuthorModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataAuthor>[];
      json['data'].forEach((v) {
        data!.add(DataAuthor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataAuthor {
  int? id;
  AttributeAuthors? attributes;

  DataAuthor({this.id, this.attributes});

  DataAuthor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? AttributeAuthors.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (attributes != null) {
      data['attributes'] = attributes!.toJson();
    }
    return data;
  }
}

class AttributeAuthors {
  String? name;
  String? shortBiography;
  String? createdAt;
  String? updatedAt;
  Thumbnail? photo;

  AttributeAuthors({this.name, this.shortBiography, this.createdAt, this.updatedAt});

  AttributeAuthors.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    shortBiography = json['short_biography'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    photo = Thumbnail.fromJson(json['photo']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['short_biography'] = shortBiography;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['photo'] = photo;
    return data;
  }
}
