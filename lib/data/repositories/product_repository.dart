
//Repository for managing product-related data and operation
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:learn_ecommerce/data/models/product_model.dart';
import 'package:learn_ecommerce/data/repositories/firebase_storage_services.dart';
import 'package:learn_ecommerce/utils/constants/enums.dart';
import 'package:learn_ecommerce/utils/exceptions/firebase_exceptions.dart';
import 'package:learn_ecommerce/utils/exceptions/platform_exceptions.dart';

class ProductRepository extends GetxController{
  static ProductRepository get instance => Get.find();

  //Firestore instance for database interaction
  final _db = FirebaseFirestore.instance;

  //Get limited featued products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db.collection('Products').where('IsFeatured', isEqualTo: true).limit(4).get();
      return snapshot.docs.map((e) => ProductModel.fromSnaphot(e)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    }  on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again after some time';
    }
  }

  //Upload dummy data to cloud firebase
  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      //Upload all products along with thei images
      final storage = Get.put(TFirebaseStorageService());

      //Loop through each product
      for(var product in products) {
        //Get image data link from local assets
        final thumbnail = await storage.getImageDataFromAssets(product.thumbnail);

        //upload image and gets its url
        final url = await storage.uploadImageData('Products/Images', thumbnail, product.thumbnail.toString());

        //Assign url to product.thumbanil attribute
        product.thumbnail = url;

        //Product list of images
        if(product.images != null && product.images!.isNotEmpty) {
          List<String> imagesUrl = [];
          for(var image in product.images!) {
            //Get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(image);

            //Upload image and gets its url
            final url = await storage.uploadImageData('Products/Images', assetImage, image);

            //assign url to product.thumbnail attribute
            imagesUrl.add(url);
          }
          product.images!.clear();
          product.images!.addAll(imagesUrl);
        }

        //upload vaiation images
        if(product.productType == ProductType.variable.toString()) {
          for (var variation in product.productVariations!) {
            //Get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(variation.image);

            //Upload image and gets its url
            final url = await storage.uploadImageData('Products/Images', assetImage,variation.image);

            //assign url to product.thumbnail attribute
            variation.image = url;

          }
        }

        //store product in firestore
        await _db.collection('Products').doc(product.id).set(product.toJson());
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}