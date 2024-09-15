import 'package:flutter/material.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/profuctcard.dart';
import 'package:learn_ecommerce/common/widgets/layout/gridview.dart';
import 'package:learn_ecommerce/common/widgets/layout/t_sectionheading.dart';
import 'package:learn_ecommerce/data/models/category_model.dart';
import 'package:learn_ecommerce/data/models/product_model.dart';
import 'package:learn_ecommerce/features/screens/store.dart';
import 'package:learn_ecommerce/utils/constants/image_strings.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.category});

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            //Brands
            const TBrandShowcase(images: [TImages.productImage1, TImages.productImage3,TImages.productImage2]),
            const TBrandShowcase(images: [TImages.productImage1, TImages.productImage3,TImages.productImage2]),
            const SizedBox(height: TSizes.spaceBtwItems),

            ///Products
            TSectionHeading(title: 'You might like',  onPressed: () {}),
            const SizedBox(height: TSizes.spaceBtwItems),

            TGridLayout(itemCount: 4, itemBuilder: (_, index) => TProductCardVertical(product: ProductModel.empty())),
            const SizedBox(height: TSizes.spaceBtwSections),
          ],
        ),)
      ],
    );
  }
}