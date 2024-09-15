import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/profuctcard.dart';
import 'package:learn_ecommerce/common/widgets/layout/gridview.dart';
import 'package:learn_ecommerce/features/controllers/product_controller.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';
class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
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
          TGridLayout(itemCount: 11, itemBuilder: (_, index) => TProductCardVertical(product: controller.featuredProducts[index]))
      ],
    );
  }
}