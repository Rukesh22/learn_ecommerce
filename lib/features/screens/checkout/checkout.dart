import 'package:flutter/material.dart';
import 'package:learn_ecommerce/common/styles/rounded_container.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/appbar.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/success_screen.dart';
import 'package:learn_ecommerce/features/screens/cart/widgets/cart_items.dart';
import 'package:learn_ecommerce/features/screens/checkout/billing_address_section.dart';
import 'package:learn_ecommerce/features/screens/checkout/billing_amount_section.dart';
import 'package:learn_ecommerce/features/screens/checkout/billing_payment_section.dart';
import 'package:learn_ecommerce/features/screens/checkout/coupon.dart';
import 'package:learn_ecommerce/navigation_menu.dart';
import 'package:learn_ecommerce/utils/constants/colors.dart';
import 'package:learn_ecommerce/utils/constants/image_strings.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:learn_ecommerce/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar( showBackArrow: true, title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall)),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            //Items ain the cart
            const TCartItems(showAddRemoveButtons: false),
            const SizedBox(height: TSizes.spaceBtwSections),

            //Coupons TextField
            const TCouponCode(),
            const SizedBox(height: TSizes.spaceBtwSections),

            //Billing Section
            TRoundedContainer(
              showBorder: true,
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: dark ? TColors.black : TColors.white,
              child: const Column(
                children: [
                  // Pricing
                  TBillingAMountSection(),
                  SizedBox(height: TSizes.spaceBtwSections),

                  //Divider
                  Divider(),
                  SizedBox(height: TSizes.spaceBtwSections),

                  //Payment Methods
                  TBillingPaymentSection(),
                  SizedBox(height: TSizes.spaceBtwSections),

                  //Address
                  TBillingAddressSection(),
                ],
              ),
            )

          ],
        ),
        ),
        ),
      //Checkout Button
      bottomNavigationBar: Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: ElevatedButton(onPressed: () => Get.to(() => SuccessScreen(
        image: TImages.successfulPaymentIcon,
        title: 'Payment Success!',
        subTitle: 'Your item will be shipped soon!',
        onPressed: () => Get.offAll(() => const NavigationMenu()),
      )), child: const Text('Checkout \$256.0'))
      ),
    );
  }
}
