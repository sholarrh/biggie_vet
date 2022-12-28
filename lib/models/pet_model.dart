
import 'dart:convert';

PetModel getCLassModelFromJson(String str) => PetModel.fromJson(json.decode(str));

class PetModel {
  int? count;
  List<Data>? data;

  PetModel({this.count, this.data});

  PetModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? breed;
  String? age;
  int? isAvailable;
  String? petPicture;
  String? cost;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
        this.breed,
        this.age,
        this.isAvailable,
        this.petPicture,
        this.cost,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    breed = json['breed'];
    age = json['age'];
    isAvailable = json['isAvailable'];
    petPicture = json['petPicture'];
    cost = json['cost'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['breed'] = this.breed;
    data['age'] = this.age;
    data['isAvailable'] = this.isAvailable;
    data['petPicture'] = this.petPicture;
    data['cost'] = this.cost;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
