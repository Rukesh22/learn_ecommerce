import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_ecommerce/data/repositories/autentication_repository.dart';
import 'package:learn_ecommerce/features/controllers/signup/verify_email_controller.dart';
import 'package:learn_ecommerce/utils/constants/image_strings.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:learn_ecommerce/utils/constants/text_strings.dart';
import 'package:learn_ecommerce/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';


class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email,});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => AutenticationRepository.instance.logout(),
              icon: const Icon(CupertinoIcons.clear)),
              ]
              ),
        
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Image(
                  image: const AssetImage(TImages.deliveredEmailIllustration),
                  width: THelperFunctions.screenWidth() * 0.6),
              const SizedBox(height: TSizes.spaceBtwSections),

              //Title & SubTitle
              Text(TTexts.confirmEmail,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(email ?? '',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(TTexts.confirmEmailSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Buttons
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.checkEmailVerificstionStatus(),
                      child: const Text(TTexts.tContinue))),
              const SizedBox(height: TSizes.spaceBtwItems),
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: ()=>controller.sendEmailVerification(), child: const Text(TTexts.resendEmail))),
            ],
          ),
        ),
      ),
    );
  }
}
  