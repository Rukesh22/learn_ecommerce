import 'package:cloud_firestore/cloud_firestore.dart';
class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;


  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.parentId = ''
  });

  //Empty Helper Function
  static CategoryModel empty() => CategoryModel(id: '', name: '', image: '', isFeatured: false);

  //Convert model to Json structure so that you can store data in firestore
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image':image,
      'ParentId': parentId,
      'IsFeatured':isFeatured
    };
  }

  //Map Json oriented document snapshot from firebase to Usermodel
  factory Category
}