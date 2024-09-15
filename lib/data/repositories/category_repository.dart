
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:learn_ecommerce/data/models/category_model.dart';
import 'package:learn_ecommerce/data/repositories/firebase_storage_services.dart';
import 'package:learn_ecommerce/utils/exceptions/firebase_exceptions.dart';
import 'package:learn_ecommerce/utils/exceptions/platform_exceptions.dart';

class CategoryRepository extends GetxController{
  static CategoryRepository get instance => Get.find();

  //variables
  final _db = FirebaseFirestore.instance;

  //Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    }  on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  //Upload Categories to the cloud Firebase
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      //upload the categorie salong with their images
      final storage = Get.put(TFirebaseStorageService());

      //Loop through each category
      for(var category in categories) {
        //Get Image Data link from local assets
        final file = await storage.getImageDataFromAssets(category.image);

        //upload image and gets its url
        final url = await storage.uploadImageData('Categories', file, category.name);

        //Assign url to categoy.image attribute
        category.image = url;

        //Store categoy in firestore
        await _db.collection('Categories').doc(category.id).set(category.toJson());
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}