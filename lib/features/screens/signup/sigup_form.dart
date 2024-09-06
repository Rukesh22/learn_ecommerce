

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learn_ecommerce/features/controllers/signup/signup_controller.dart';
import 'package:learn_ecommerce/utils/constants/colors.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:learn_ecommerce/utils/constants/text_strings.dart';
import 'package:learn_ecommerce/utils/helpers/helper_functions.dart';
import 'package:learn_ecommerce/utils/validators/validation.dart';
class TSignupForm extends StatelessWidget {
  const TSignupForm({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(SignupController());
    final tccontroller = SignupController.instance;
    return Form(
      key: controller.signupFormKey,
      child: Column(
      children: [
        Row(
          children: [
            Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) => TValidator.validateEmptyText('First name', value),
              expands: false,
              decoration: const InputDecoration(
                  labelText: TTexts.firstName,
                  prefixIcon: Icon(Iconsax.user)),
            )),
            const SizedBox(width: TSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                controller: controller.lastName,
                validator: (value) => TValidator.validateEmptyText('Last name', value),
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
          controller: controller.username,
          validator: (value) => TValidator.validateEmptyText('Username', value),
          expands: false,
          decoration: const InputDecoration(
              labelText: TTexts.username,
              prefixIcon: Icon(Iconsax.user_edit)),
        ),
    
        const SizedBox(height: TSizes.spaceBtwInputFields),
    
        //Email
        TextFormField(
          controller: controller.email,
          validator: (value) => TValidator.validateEmail(value),
          expands: false,
          decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct)),
        ),
    
        const SizedBox(height: TSizes.spaceBtwInputFields),
    
        //phoneNumber
        TextFormField(
          controller: controller.phoneNumber,
          validator: (value) => TValidator.validatePhoneNumber(value),
          expands: false,
          decoration: const InputDecoration(
              labelText: TTexts.phoneNo,
              prefixIcon: Icon(Iconsax.call)),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),
    
        //password
        Obx(
          () => TextFormField(
            controller: controller.password,
            validator: (value) => TValidator.validatePassword(value),
            obscureText: controller.hidePassword.value,
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.password_check),
              labelText: TTexts.password,
              suffixIcon: IconButton(onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
              icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye)),
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
    
        //T&C CheckBox
        Row(
          children: [
            SizedBox(
              width: 24, height: 24, child: Obx(() => Checkbox(value: tccontroller.privacypolicy.value,
              onChanged: (value) => tccontroller.privacypolicy.value = !tccontroller.privacypolicy.value)
              ),
              ),
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

        const SizedBox(height: TSizes.spaceBtwSections),
        //signup Button
        SizedBox(width: double.infinity,
        child: ElevatedButton(
        onPressed: () => controller.signup(),
        child: const Text(TTexts.createAccount))),
      ],
    ),
    );
  }
}
