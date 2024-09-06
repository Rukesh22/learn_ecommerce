import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learn_ecommerce/features/screens/login.dart';

class OnboardingController extends GetxController{ 
  static OnboardingController get instance => Get.find();

//variable
final pageController = PageController();
Rx<int> currentPageIndex = 0.obs;

//update current index when page scroll
void updatePageIndicator(index) => currentPageIndex = index;

//jump to the specific dot selected page
void dotNavigationClick(index) {
  currentPageIndex.value = index;
  pageController.jumpTo(index);
}

//update current Index & jump to next page
void nextPage() {
  if(currentPageIndex.value == 2){
    Get.offAll(const LoginScreen());
  }
  else{
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