import 'package:flutter/material.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/profuctcard.dart';
import 'package:learn_ecommerce/common/widgets/layout/gridview.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';
class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          items: ['Name', 'Higher Price', 'Lower Price', 'Sale', 'Newest', 'Popularity']
          .map((option) => DropdownMenuItem(value: option,child: Text(option)))
          .toList(),
          onChanged: (value) {}),
          const SizedBox(height: TSizes.spaceBtwSections),
    
          //Products
          TGridLayout(itemCount: 11, itemBuilder: (_, index) => const TProductCardVertical())
      ],
    );
  }
}