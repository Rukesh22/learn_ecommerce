import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learn_ecommerce/features/screens/login/login.dart';

class OnboardingController extends GetxController{ 
  static OnboardingController get instance => Get.find();

//variable
final pageController = PageController();
Rx<int> currentPageIndex = 0.obs;

//update current index when page scroll
void updatePageIndicator(index) => currentPageIndex.value = index;

//jump to the specific dot selected page
void dotNavigationClick(index) {
  currentPageIndex.value = index;
  pageController.jumpTo(index);
}

//update current Index & jump to next page
//update current Index & jump to next page
void nextPage() {
  if(currentPageIndex.value == 2){
    final storage = GetStorage();

 
    //Local Storage
    if (kDebugMode) {
      print('============GET STORAGE Next========');
      print(storage.read('IsFirstTime'));
    }

    
    storage.write('IsFirstTime', false);
    Get.offAll(const LoginScreen());
  }else{
    int page = currentPageIndex.value + 1;
    pageController.jumpToPage(page);
  }
}

//update current Index & Jump to last Page
void skipPage() {
  currentPageIndex.value = 2;
  pageController.jumpToPage(2);
}

}