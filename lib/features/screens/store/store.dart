import 'package:flutter/material.dart';
import 'package:learn_ecommerce/common/styles/brand_shimmer.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/appbar.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/tabbar.dart';
import 'package:learn_ecommerce/features/screens/store/widgets/category_tab.dart';
import 'package:learn_ecommerce/common/widgets/layout/gridview.dart';
import 'package:learn_ecommerce/common/widgets/layout/t_searchbar.dart';
import 'package:learn_ecommerce/common/widgets/layout/t_sectionheading.dart';
import 'package:learn_ecommerce/features/controllers/product/brand_controller.dart';
import 'package:learn_ecommerce/features/controllers/product/category_controller.dart';
import 'package:learn_ecommerce/features/screens/all_brands/all_brands.dart';
import 'package:learn_ecommerce/features/screens/all_brands/brand_card.dart';
import 'package:learn_ecommerce/features/screens/all_brands/brand_products.dart';
import 'package:learn_ecommerce/utils/constants/colors.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:learn_ecommerce/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../cart/CartScreen.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());
    final categories = CategoryController.instance.featureCategories;
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: TAppBar(
          title:
              Text('Store', style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            Stack(
              children: [
                IconButton(
                    onPressed: () => Get.to(const Cartscreen()),
                    icon: const Icon(
                      Iconsax.shopping_bag,
                      color: TColors.black,
                    )),
                Positioned(
                    right: 0,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: TColors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Text(
                          '2',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: TColors.black, fontSizeFactor: 0.8),
                        ),
                      ),
                    ))
              ],
            )
          ],
        ),
        body: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  backgroundColor: THelperFunctions.isDarkMode(context)
                      ? TColors.black
                      : TColors.white,
                  expandedHeight: 440,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        //Search bar
                        const SizedBox(height: TSizes.spaceBtwItems),
                        const TSearchContainer(
                            text: 'Search in Store',
                            showBorder: true,
                            showBackground: false,
                            padding: EdgeInsets.zero),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        //Featured Brands
                        TSectionHeading(
                            title: 'Featured Brands', onPressed: () => Get.to(() => const AllBrandsScreen())),
                        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                        //Brand Grid
                        Obx(()
                        {
                          if(brandController.isLoading.value) return const TBrandShimmer();

                          if(brandController.featuredBrands.isEmpty) {
                            return Center(
                              child: Text('No data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
                          }

                          return TGridLayout(
                            itemCount: brandController.featuredBrands.length,
                            mainAxisExtent: 80,
                            itemBuilder: (_, index) {
                              final brand = brandController.featuredBrands[index];
                              return TBrandCard(showBorder: true, brand: brand, onTap: () => Get.to(() => BrandProducts(brand: brand)));
                            });
                        })
                      ],
                    ),
                  ),

                  //TAbs
                 bottom: TTabBar(tabs: 
                    categories.map((category) => Tab(child: Text(category.name))).toList()),
                  ),
                
              ];
            },
            body:TabBarView(children: 
              categories.map((category) => TCategoryTab(category: category)).toList()
            )
            ),
      ),
    );
  }
}