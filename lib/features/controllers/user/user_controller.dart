

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:learn_ecommerce/data/models/user_models.dart';
import 'package:learn_ecommerce/data/repositories/user_repository.dart';
import 'package:learn_ecommerce/utils/helpers/t_loader.dart';

class UserController extends GetxController{
  static UserController get instance => Get.find();


final userRepository = Get.put(UserRepository());

  //Save user Record from any registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null) {
        //Convert Name to first and Last Name
        final nameParts = UserModel.nameParts(userCredentials.user!.displayName ?? '');
        final username = UserModel.generateUsername(userCredentials.user!.displayName ?? '');

        //Map DAta
        final user = UserModel(
          id: userCredentials.user!.uid,
          username: username,
          email: userCredentials.user!.email ?? '',
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : ' ',
          phoneNumber: userCredentials.user!.phoneNumber ?? '',
          profilePicture: userCredentials.user!.photoURL ?? '');


          //Save User data
          await userRepository.saveUserRecord(user);
      }
    }  catch (e) {
      TLoaders.warningSnackBar(title: 'Data not Saved',
      message: 'Somoeting went wrong while saving your information. You can re-save your data in your profile');
    }
  }
}