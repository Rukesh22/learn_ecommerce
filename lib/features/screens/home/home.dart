
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/curved_edges.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/profuctcard.dart';
import 'package:learn_ecommerce/common/widgets/layout/gridview.dart';
import 'package:learn_ecommerce/common/widgets/layout/t_circular_container.dart';
import 'package:learn_ecommerce/common/widgets/layout/t_rounded_image.dart';
import 'package:learn_ecommerce/common/widgets/layout/t_sectionheading.dart';
import 'package:learn_ecommerce/features/controllers/homecontroller/home_controller.dart';
import 'package:learn_ecommerce/features/screens/all_products/all_products.dart';
import 'package:learn_ecommerce/features/screens/home/home_appbar.dart';
import 'package:learn_ecommerce/features/screens/subcategories/sub_categories.dart';
import 'package:learn_ecommerce/utils/constants/colors.dart';
import 'package:learn_ecommerce/utils/constants/image_strings.dart';
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
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                SizedBox(
                                  height: 80,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: 6,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (_, index) {
                                        return GestureDetector(
                                          onTap: () => Get.to(() => const SubCategoriesScreen()),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: TSizes.spaceBtwItems),
                                            child: Column(
                                              children: [
                                                //Circular Icon
                                                Container(
                                                  width: 56,
                                                  height: 56,
                                                  padding: const EdgeInsets.all(
                                                      TSizes.sm),
                                                  decoration: BoxDecoration(
                                                      color: TColors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
                                                  child: const Center(
                                                    child: Image(
                                                        image: AssetImage(
                                                            TImages.shoeIcon),
                                                        fit: BoxFit.cover,
                                                        color: TColors.dark),
                                                  ),
                                                ),

                                                //Text
                                                const SizedBox(
                                                    height:
                                                        TSizes.spaceBtwItems /
                                                            2),
                                                SizedBox(
                                                    width: 55,
                                                    child: Text('Shoes',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelMedium!
                                                            .apply(
                                                                color: TColors
                                                                    .white),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis))
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                )
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
                  CarouselSlider(
                    options: CarouselOptions(
                        viewportFraction: 1,
                        onPageChanged: (index, _) =>
                            controller.updatePageIndicator(index)),
                    items: const [
                      TRoundedImage(imageUrl: TImages.promoBanner1),
                      TRoundedImage(imageUrl: TImages.promoBanner2),
                      TRoundedImage(imageUrl: TImages.promoBanner3),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Center(
                    child: Obx(
                      () => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 0; i < 3; i++)
                            TCircukarContainer(
                                width: 20,
                                height: 4,
                                margin: const EdgeInsets.only(right: 10),
                                backgroundColor:
                                    controller.carousalCurrentIndex.value == i
                                        ? TColors.primary
                                        : TColors.grey)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  //Heading
                  TSectionHeading(title: 'Popular Products', onPressed: () => Get.to(() => const AllProducts())),

                  //Popular Products
                  TGridLayout(itemCount: 4, itemBuilder: (_, index) => const TProductCardVertical())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
