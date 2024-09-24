import 'package:flutter/material.dart';
import 'package:learn_ecommerce/common/styles/brand_shimmer.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/appbar.dart';
import 'package:learn_ecommerce/common/widgets/layout/gridview.dart';
import 'package:learn_ecommerce/common/widgets/layout/t_sectionheading.dart';
import 'package:learn_ecommerce/features/controllers/product/brand_controller.dart';
import 'package:learn_ecommerce/features/screens/all_brands/brand_card.dart';
import 'package:learn_ecommerce/features/screens/all_brands/brand_products.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:get/get.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: const TAppBar(title: Text('All Brands'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //Heading
              const TSectionHeading(title: 'Brands', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              //Brands
              Obx(() {
                if (brandController.isLoading.value) return const TBrandShimmer();

                if (brandController.allBrands.isEmpty) {
                  return Center(child: Text('No data Found!',style: Theme.of(context).textTheme .bodyMedium!.apply(color: Colors.white)));
                }

                return TGridLayout(
                    itemCount: brandController.featuredBrands.length,
                    mainAxisExtent: 80,
                    itemBuilder: (_, index) {
                      final brand = brandController.allBrands[index];
                      
                      return TBrandCard(showBorder: true, brand: brand,
                      onTap: () => Get.to(() => BrandProducts(brand: brand)),
                      );
                    }
                    );
              })
            ],
          ),
        ),
      ),
    );
  }
}
