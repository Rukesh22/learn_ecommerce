import 'package:flutter/material.dart';
import 'package:learn_ecommerce/features/controllers.onboarding/onboarding_controller.dart';
import 'package:learn_ecommerce/utils/constants/colors.dart';
import 'package:learn_ecommerce/utils/constants/image_strings.dart';
import 'package:learn_ecommerce/utils/constants/text_strings.dart';
import 'package:learn_ecommerce/utils/device/device_utility.dart';
import 'package:learn_ecommerce/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/constants/sizes.dart';


class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {


    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(OnboardingController());
    final controllerdot = OnboardingController.instance;

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              ObBoardingpage(
                image: TImages.onBoardingImage1,
                title: TTexts.onBoardingTitle1,
                subTitle: TTexts.onBoardingSubTitle1,
              ),
              ObBoardingpage(
                image: TImages.onBoardingImage2,
                title: TTexts.onBoardingTitle2,
                subTitle: TTexts.onBoardingSubTitle2,
              ),
              ObBoardingpage(
                image: TImages.onBoardingImage3,
                title: TTexts.onBoardingTitle3,
                subTitle: TTexts.onBoardingSubTitle3,
              ),
            ],
          ),

//Skip Button
          Positioned(
            top: TDeviceUtils.getAppBarHeight(),
            right: TSizes.defaultSpace,
            child: TextButton(onPressed: () => OnboardingController.instance.skipPage(), child: const Text('Skip')),
          ),
//Dot Navigation
          Positioned(
              bottom: TDeviceUtils.getBottomNavigationBarHeight() + 25,
              left: TSizes.defaultSpace,
              child: SmoothPageIndicator(
                controller: controllerdot.pageController,
                onDotClicked: controllerdot.dotNavigationClick,
                count: 3,
                effect: ExpandingDotsEffect(
                    activeDotColor: dark ? TColors.light : TColors.dark,
                    dotHeight: 6),
              )),

//Circular Button
          Positioned(
            right: TSizes.defaultSpace,
            bottom: TDeviceUtils.getBottomNavigationBarHeight(),
            child: ElevatedButton(
              onPressed: () => OnboardingController.instance.nextPage(),
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(), backgroundColor: dark ? TColors.primary: Colors.black),
              child: const Icon(Iconsax.arrow_right3),
            ),
          ),


        ],
      ),
    );
  }
}

class ObBoardingpage extends StatelessWidget {
  const ObBoardingpage(
      {super.key,
      required this.image,
      required this.subTitle,
      required this.title});

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          Image(
              width: THelperFunctions.screenWidth() * 0.8,
              height: THelperFunctions.screenHeight() * 0.6,
              image: AssetImage(image)),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
