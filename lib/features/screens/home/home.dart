import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/curved_edges.dart';
import 'package:learn_ecommerce/features/screens/products/product_cards/profuctcard_vertical.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/vertical_product_shimmer.dart';
import 'package:learn_ecommerce/common/widgets/layout/gridview.dart';
import 'package:learn_ecommerce/common/widgets/layout/t_circular_container.dart';
import 'package:learn_ecommerce/common/widgets/layout/t_sectionheading.dart';
import 'package:learn_ecommerce/features/controllers/homecontroller/home_controller.dart';
import 'package:learn_ecommerce/features/controllers/product/product_controller.dart';
import 'package:learn_ecommerce/features/screens/all_products/all_products.dart';
import 'package:learn_ecommerce/features/screens/home/home_appbar.dart';
import 'package:learn_ecommerce/features/screens/home/home_categories.dart';
import 'package:learn_ecommerce/features/screens/home/t_promoslider.dart';
import 'package:learn_ecommerce/utils/constants/colors.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:learn_ecommerce/utils/device/device_utility.dart';
import 'package:learn_ecommerce/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen(
      {super.key,
      this.showBackground = true,
      this.showBorder = true,
      this.showActionButton = false,
      this.onTap});

  final bool showBackground, showBorder, showActionButton;
  final void Function()? onTap;
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: TCustomCurvedEdges(),
              child: Container(
                color: TColors.primary,
                padding: const EdgeInsets.all(0),
                child: SizedBox(
                  height: 400,
                  child: Stack(
                    children: [
                      Positioned(
                          top: -105,
                          right: -250,
                          child: TCircukarContainer(
                              backgroundColor:
                                  TColors.textWhite.withOpacity(0.1))),
                      Positioned(
                          top: 100,
                          right: -300,
                          child: TCircukarContainer(
                              backgroundColor:
                                  TColors.textWhite.withOpacity(0.1))),
                      Column(
                        children: [
                          const THomeAppBar(),

                          const SizedBox(height: TSizes.spaceBtwSections),

                          //Search Bar
                          GestureDetector(
                            onTap: onTap,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: TSizes.defaultSpace),
                              child: Container(
                                width: TDeviceUtils.getScreenWidth(context),
                                padding: const EdgeInsets.all(TSizes.md),
                                decoration: BoxDecoration(
                                    color: showBackground
                                        ? dark
                                            ? TColors.dark
                                            : TColors.light
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(
                                        TSizes.cardRadiusLg),
                                    border: showBorder
                                        ? Border.all(color: TColors.grey)
                                        : null),
                                child: Row(
                                  children: [
                                    const Icon(Iconsax.search_normal,
                                        color: TColors.darkGrey),
                                    const SizedBox(width: TSizes.spaceBtwItems),
                                    Text('Search in Store',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall)
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: TSizes.spaceBtwSections),

                          //CAtegories
                          Padding(
                            padding: const EdgeInsets.only(
                                left: TSizes.defaultSpace),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Popular Categories",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall!
                                                .apply(color: Colors.black),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis),
                                        if (showActionButton)
                                          TextButton(
                                              onPressed: () {},
                                              child: const Text('View All'))
                                      ],
                                    )
                                  ],
                                ),

                                const SizedBox(height: TSizes.spaceBtwItems),

                                //Categories
                                const THomeCategories()
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),

            //Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const TPromoSlider(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  //Heading
                  TSectionHeading(
                      title: 'Popular Products',
                      onPressed: () => Get.to(() => AllProducts(
                        title: 'Popular Products',
                        query: FirebaseFirestore.instance.collection('Products').where('IsFeatured', isEqualTo: true).limit(6),
                        futureMethod: controller.fetchAllFeaturedProducts()))
                        ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  //Popular Products
                  Obx(() {
                    if(controller.isLoading.value) return const TVerticalProductShimmer();

                    if (controller.featuredProducts.isEmpty) {
                      return Center(child: Text('No data found!', style: Theme.of(context).textTheme.bodyMedium));
                    }

                    return TGridLayout(
                      itemCount: controller.featuredProducts.length,
                      itemBuilder: (_, index) => TProductCardVertical(product: controller.featuredProducts[index]),
                      );
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

