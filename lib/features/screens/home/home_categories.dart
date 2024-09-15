
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/category_shimmer.dart';
import 'package:learn_ecommerce/common/widgets/layout/tvertical_image_text.dart';
import 'package:learn_ecommerce/features/screens/subcategories/sub_categories.dart';

import '../../controllers/category_controller.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final categoryController = Get.put(CategoryController());

    return Obx(() {
      if(categoryController.isLoading.value) return const TCategoryShimmer();

      if(categoryController.featureCategories.isEmpty) {
        return Center(child: Text('No data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
      }
      return SizedBox(
      height: 80,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: categoryController.featureCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            //
            final category = categoryController.featureCategories[index];
            return TverticalImageText(image: category.image, title:category.name, onTap: () => Get.to(() => const SubCategoriesScreen()));
          }),
    );
    }
    );
  }
}
