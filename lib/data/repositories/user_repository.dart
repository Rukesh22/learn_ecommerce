

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_ecommerce/data/models/user_models.dart';
import 'package:learn_ecommerce/data/repositories/autentication_repository.dart';
import 'package:learn_ecommerce/utils/exceptions/firebase_exceptions.dart';
import 'package:learn_ecommerce/utils/exceptions/format_exceptions.dart';
import 'package:learn_ecommerce/utils/exceptions/platform_exceptions.dart';

class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;


  //Functions to save user data to Firestore
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("User").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
    throw TFirebaseException(e.code).message; 
  } on FormatException catch (_) {
    throw const TFormatException();
  } on PlatformException catch (e) {
    throw TPlatformException(e.code).message;
  } catch (e) {
    throw 'Something went wrong. Please try again';
  }
  }

  //Function to fetch user details based on user ID
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db.collection("User").doc(AutenticationRepository.instance.authUser?.uid).get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
    throw TFirebaseException(e.code).message; 
  } on FormatException catch (_) {
    throw const TFormatException();
  } on PlatformException catch (e) {
    throw TPlatformException(e.code).message;
  } catch (e) {
    throw 'Something went wrong. Please try again';
  }
  }

  //Function to update user data in Firestore
  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
    await _db.collection("User").doc(updateUser.id).update(updateUser.toJson());
    } on FirebaseException catch (e) {
    throw TFirebaseException(e.code).message; 
  } on FormatException catch (_) {
    throw const TFormatException();
  } on PlatformException catch (e) {
    throw TPlatformException(e.code).message;
  } catch (e) {
    throw 'Something went wrong. Please try again';
  }
  }

  // Update any field in specific User Collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
    await _db.collection("User").doc(AutenticationRepository.instance.authUser?.uid).update(json);
    } on FirebaseException catch (e) {
    throw TFirebaseException(e.code).message; 
  } on FormatException catch (_) {
    throw const TFormatException();
  } on PlatformException catch (e) {
    throw TPlatformException(e.code).message;
  } catch (e) {
    throw 'Something went wrong. Please try again';
  }
  }

  //Function to remove user data from firestore
  Future<void> removeUserRecord(String userId) async {
    try {
    await _db.collection("User").doc(userId).delete();
    } on FirebaseException catch (e) {
    throw TFirebaseException(e.code).message; 
  } on FormatException catch (_) {
    throw const TFormatException();
  } on PlatformException catch (e) {
    throw TPlatformException(e.code).message;
  } catch (e) {
    throw 'Something went wrong. Please try again';
  }
  }

  //Upload any image
  Future<String> uploadImage(String path, XFile image) async {
   try {
    final ref = FirebaseStorage.instance.ref(path).child(image.name);
    await ref.putFile(File(image.path));
    final url = await ref.getDownloadURL();
    return url;
    } on FirebaseException catch (e) {
    throw TFirebaseException(e.code).message; 
  } on FormatException catch (_) {
    throw const TFormatException();
  } on PlatformException catch (e) {
    throw TPlatformException(e.code).message;
  } catch (e) {
    throw 'Something went wrong. Please try again';
  }
  }
}