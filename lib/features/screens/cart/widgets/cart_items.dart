import 'package:flutter/material.dart';
import 'package:learn_ecommerce/features/screens/cart/cartScreen.dart';
import 'package:learn_ecommerce/features/screens/product_detail.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (_, __) =>
              const SizedBox(height: TSizes.spaceBtwSections),
          itemCount: 2,
          itemBuilder: (_, index) => Column(
            children: [

              //Cart Item
              const TCartItem(),
              if (showAddRemoveButtons) const SizedBox(height: TSizes.spaceBtwItems),

              //Add Remove button Row with total price
              if(showAddRemoveButtons)
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      //Extra Space
                      SizedBox(width: 70),
                  //Add Remove Button
                  TProductQuantityWithAddRemoveButton(),
                  
                    ],
                  ),

                  //Product Total Price
                  TProductPriceText(price: '256'),
                ],
              ),
            ],
          ),
        );
  }
}