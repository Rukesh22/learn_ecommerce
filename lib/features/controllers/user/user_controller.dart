import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_ecommerce/data/models/user_models.dart';
import 'package:learn_ecommerce/data/repositories/autentication_repository.dart';
import 'package:learn_ecommerce/data/repositories/user_repository.dart';
import 'package:learn_ecommerce/features/controllers/signup/signup_controller.dart';
import 'package:learn_ecommerce/features/screens/login/login.dart';
import 'package:learn_ecommerce/features/screens/profile/re_authenticate_user_login_form.dart';
import 'package:learn_ecommerce/utils/constants/image_strings.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:learn_ecommerce/utils/helpers/network_manager.dart';
import 'package:learn_ecommerce/utils/helpers/t_loader.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());
  final profileLoading = false.obs;
  final imageUploading = false.obs;
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  //Fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
      profileLoading.value = false;
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  //Save user Record from any registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {

      user.refresh();

      //Refresh user record
      await fetchUserRecord();

      //If no record alreday stored
      if(user.value.id.isEmpty) {
      if (userCredentials != null) {
        //Convert Name to first and Last Name
        final nameParts =
            UserModel.nameParts(userCredentials.user!.displayName ?? '');
        final username =
            UserModel.generateUsername(userCredentials.user!.displayName ?? '');

        //Map DAta
        final user = UserModel(
            id: userCredentials.user!.uid,
            username: username,
            email: userCredentials.user!.email ?? '',
            firstName: nameParts[0],
            lastName:
                nameParts.length > 1 ? nameParts.sublist(1).join(' ') : ' ',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '');

        //Save User data
        await userRepository.saveUserRecord(user);
      }
      }
    } catch (e) {
      TLoaders.warningSnackBar(
          title: 'Data not Saved',
          message:
              'Somoeting went wrong while saving your information. You can re-save your data in your profile');
    }
  }

  void deleteAccountWarningPopup() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(TSizes.md),
        title: 'Delete Account',
        middleText:
            'Are you sure you want to delete this account permanently? This action is nit reversible and all your data will be removed permannently.',
        confirm: ElevatedButton(
            onPressed: () async => deleteUserAccount(),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                side: const BorderSide(color: Colors.red)),
            child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
                child: Text('Delete'))),
        cancel: OutlinedButton(
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: const Text('Cancel')));
  }

  //Delete User Account
  void deleteUserAccount() async {
    try {
      //Strat Loading
      TFullScreenLoader.openLoadingDialog('Processing', TImages.docerAnimation);

      //First re-autenticate user
      final auth = AutenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        // Re verify with Auth Email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          TFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  //Re-autenticate before deleting
  Future<void> reAutenticateEmailAndPasswordUser() async {
    try {
      //Strat Loading
      TFullScreenLoader.openLoadingDialog('Processing', TImages.docerAnimation);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      //Form validation
      if (!reAuthFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AutenticationRepository.instance.reAutenticateEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
      await AutenticationRepository.instance.deleteAccount();
      TFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  //upload profile image
  uploadUserProfilePicture() async {
    try {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 70, maxHeight: 512, maxWidth: 512);
    if(image != null) {
      imageUploading.value = true;
      //upload image
      final imageUrl = await userRepository.uploadImage('User/Images/Profile/', image);

      //update user image record
      Map<String, dynamic> json = {'ProfilePicture' : imageUrl};
      await userRepository.updateSingleField(json);

      user.value.profilePicture = imageUrl;
      user.refresh();
      TLoaders.successSnabar(title: 'Congragylations', message: 'Your profile Image has been updated');
    }
  } catch (e) {
    TLoaders.warningSnackBar(title: 'Oh Snap!', message: 'Something went wrong: $e');
  }

  finally {
    imageUploading.value = false;
  }
}
}