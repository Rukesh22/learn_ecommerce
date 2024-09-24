import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_ecommerce/features/screens/products/product_cards/profuctcard_vertical.dart';
import 'package:learn_ecommerce/common/widgets/layout/gridview.dart';
import 'package:learn_ecommerce/data/models/product_model.dart';
import 'package:learn_ecommerce/features/controllers/product/allproduct_controller.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';
class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key, required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    controller.assignProducts(products);
    return Column(
      children: [
        //Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          value: controller.selectedSortOption.value,
          items: ['Name', 'Higher Price', 'Lower Price', 'Sale', 'Newest', 'Popularity']
          .map((option) => DropdownMenuItem(value: option, child: Text(option)))
          .toList(),
          onChanged: (value) {
            //sort products based on the selected option
            controller.sortProducts(value!);
          }),
          const SizedBox(height: TSizes.spaceBtwSections),
    
          //Products
          Obx(() => TGridLayout(itemCount: controller.products.length, itemBuilder: (_, index) => TProductCardVertical(product: controller.products[index])))
      ],
    );
  }
}