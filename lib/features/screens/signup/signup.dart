import 'package:flutter/material.dart';
import 'package:learn_ecommerce/features/screens/signup/verify_email.dart';
import 'package:learn_ecommerce/utils/constants/colors.dart';
import 'package:learn_ecommerce/utils/constants/image_strings.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:learn_ecommerce/utils/constants/text_strings.dart';
import 'package:learn_ecommerce/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TTexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: TSizes.spaceBtwSections),

              //FOrm
              Form(
                  child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        expands: false,
                        decoration: const InputDecoration(
                            labelText: TTexts.firstName,
                            prefixIcon: Icon(Iconsax.user)),
                      )),
                      const SizedBox(width: TSizes.spaceBtwInputFields),
                      Expanded(
                        child: TextFormField(
                          expands: false,
                          decoration: const InputDecoration(
                              labelText: TTexts.lastName,
                              prefixIcon: Icon(Iconsax.user)),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: TSizes.spaceBtwInputFields),

                  ///username
                  TextFormField(
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.username,
                        prefixIcon: Icon(Iconsax.user_edit)),
                  ),

                  const SizedBox(height: TSizes.spaceBtwInputFields),

                  //Email
                  TextFormField(
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.email,
                        prefixIcon: Icon(Iconsax.direct)),
                  ),

                  const SizedBox(height: TSizes.spaceBtwInputFields),

                  //phoneNumber
                  TextFormField(
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.phoneNo,
                        prefixIcon: Icon(Iconsax.call)),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),

                  //password
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.password_check),
                      labelText: TTexts.password,
                      suffixIcon: Icon(Iconsax.eye_slash),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  //T&C CheckBox
                  Row(
                    children: [
                      SizedBox(width: 24, height: 24, child: Checkbox(value: true, onChanged: (value) {})),
                      const SizedBox(width: TSizes.spaceBtwItems),
                      Text.rich(
                        TextSpan(children: [
                          TextSpan(text: '${TTexts.iAgreeTo} ', style: Theme.of(context).textTheme.bodySmall),
                          TextSpan(text: '${TTexts.privacyPolicy} ', style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: dark ? TColors.white: TColors.primary,
                            decoration: TextDecoration.underline,
                            decorationColor: dark ? TColors.white: TColors.primary,
                          )),
                          TextSpan(text: '${TTexts.and} ', style: Theme.of(context).textTheme.bodySmall),
                          TextSpan(text: '${TTexts.termsOfUse} ', style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: dark ? TColors.white: TColors.primary,
                            decoration: TextDecoration.underline,
                            decorationColor: dark ? TColors.white: TColors.primary,
                          )),
                        ]),
                      ),
                    ],
                  ),

                  //signup Button
                  SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.to(() => const VerifyEmailScreen()), child: const Text(TTexts.createAccount))),
                ],
              ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),


              //Divider
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: Divider(
                          color: dark ? TColors.darkGrey : TColors.grey,
                          thickness: 0.5,
                          indent: 60,
                          endIndent: 5)),
                  Text(TTexts.orSignInWith.capitalize!,
                      style: Theme.of(context).textTheme.labelMedium),
                  Flexible(
                      child: Divider(
                          color: dark ? TColors.darkGrey : TColors.grey,
                          thickness: 0.5,
                          indent: 5,
                          endIndent: 60)),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              ///Socila Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: TColors.grey),
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Image(
                          image: AssetImage(TImages.google),
                          width: TSizes.iconMd,
                          height: TSizes.iconMd),
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: TColors.grey),
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Image(
                          image: AssetImage(TImages.facebook),
                          width: TSizes.iconMd,
                          height: TSizes.iconMd),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
