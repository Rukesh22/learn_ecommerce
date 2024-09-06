import 'package:flutter/material.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/appbar.dart';
import 'package:learn_ecommerce/common/widgets/layout/gridview.dart';
import 'package:learn_ecommerce/common/widgets/layout/t_sectionheading.dart';
import 'package:learn_ecommerce/features/screens/all_brands/brand_products.dart';
import 'package:learn_ecommerce/features/screens/store.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:get/get.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(title: Text('Brand'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            //Heading
            const TSectionHeading(title: 'Brands', showActionButton: false),
            const SizedBox(height: TSizes.spaceBtwItems),


            //Brands
            TGridLayout(itemCount: 10,
            mainAxisExtent: 80,
            itemBuilder: (context, index) => TBrandCard(
              showBorder: true,
              onTap: () => Get.to(() => const BrandProducts()),
            )
            )
          ],
        ),),
      ),);
  }
}