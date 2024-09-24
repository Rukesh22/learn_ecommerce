import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_ecommerce/features/screens/products/product_cards/profuctcard_vertical.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/vertical_product_shimmer.dart';
import 'package:learn_ecommerce/common/widgets/layout/gridview.dart';
import 'package:learn_ecommerce/common/widgets/layout/t_sectionheading.dart';
import 'package:learn_ecommerce/data/models/category_model.dart';
import 'package:learn_ecommerce/features/controllers/product/category_controller.dart';
import 'package:learn_ecommerce/features/screens/all_products/all_products.dart';
import 'package:learn_ecommerce/features/screens/store/widgets/category_brands.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:learn_ecommerce/utils/helpers/cloud_helper_functions.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            //Brands
            CategoryBrands(category: category),
            const SizedBox(height: TSizes.spaceBtwItems),

            ///Products
            FutureBuilder(
              future: controller.getCategoryProducts(categoryId: category.id), 
              builder: (context, snapshot) {

                //Helper function: Handle Loader, no record, or error message
                final response = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: const TVerticalProductShimmer());
                if(response != null) return response;

                //record found
                final products = snapshot.data!;

                return Column(
                  children: [
                    TSectionHeading(
                      title: 'You might like',  
                      onPressed: () => Get.to(AllProducts(
                        title: category.name,
                        futureMethod: controller.getCategoryProducts(categoryId: category.id, limit: -1)
                        )
                        )
                        ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    
                    TGridLayout(itemCount: products.length, itemBuilder: (_, index) => TProductCardVertical(product: products[index])),
                  ],
                );

              })
          ],
        ),)
      ],
    );
  }
}