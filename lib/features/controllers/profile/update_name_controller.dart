

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:learn_ecommerce/data/repositories/user_repository.dart';
import 'package:learn_ecommerce/features/controllers/signup/signup_controller.dart';
import 'package:learn_ecommerce/features/controllers/user/user_controller.dart';
import 'package:learn_ecommerce/features/screens/profile/profilescreen.dart';
import 'package:learn_ecommerce/utils/constants/image_strings.dart';
import 'package:learn_ecommerce/utils/helpers/network_manager.dart';
import 'package:learn_ecommerce/utils/helpers/t_loader.dart';

class UpdateNameController extends GetxController{
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();


  //init user data when home screen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  //Fetch User Record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  //Fetch user record
  Future<void> updateUserName() async {
    try {
      //Strat Loading
      TFullScreenLoader.openLoadingDialog('We are updating you information', TImages.docerAnimation);

      //Check Internet Connectivity
    final isConnected = await NetworkManager.instance.isConnected();

    if (!isConnected) {
      //Remove Loader
      TFullScreenLoader.stopLoading();
      return;
    }
    
    //Form validation
    if (!updateUserNameFormKey.currentState!.validate()) {
      TFullScreenLoader.stopLoading();
      return;
    }

    // Update user's first and last name in firebase firestore
    Map<String, dynamic> name = {'FirstName': firstName.text.trim(), 'LastName': lastName.text.trim()};
    await userRepository.updateSingleField(name);

    //Update the Rx user value
    userController.user.value.firstName = firstName.text.trim();
    userController.user.value.lastName = lastName.text.trim();

    //Remove Loader
    TFullScreenLoader.stopLoading();

    //Show success message
    TLoaders.successSnabar(title: 'Congratulations', message: 'Your Name has been updated');

    //Move o previous sceen
    Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}