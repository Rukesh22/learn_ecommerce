import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:learn_ecommerce/common/widgets/icons/favourite_icon.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/appbar.dart';
import 'package:learn_ecommerce/common/widgets/icons/t_circular_icon.dart';
import 'package:learn_ecommerce/common/widgets/layout/bottom_add_to_cart.dart';
import 'package:learn_ecommerce/common/widgets/layout/t_curvedEdgewidget.dart';
import 'package:learn_ecommerce/common/widgets/layout/t_rounded_image.dart';
import 'package:learn_ecommerce/common/widgets/layout/t_sectionheading.dart';
import 'package:learn_ecommerce/data/models/product_model.dart';
import 'package:learn_ecommerce/features/controllers/product/image_controller.dart';
import 'package:learn_ecommerce/features/screens/products/product_attributes.dart';
import 'package:learn_ecommerce/features/screens/products/product_review.dart';
import 'package:learn_ecommerce/features/screens/products/product_metadata.dart';
import 'package:learn_ecommerce/utils/constants/colors.dart';
import 'package:learn_ecommerce/utils/constants/enums.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:learn_ecommerce/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const TBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Product Image SLider
            TProductImageSlider(product: product),

            //Product Details
            Padding(
                padding: const EdgeInsets.only(
                    right: TSizes.defaultSpace,
                    left: TSizes.defaultSpace,
                    bottom: TSizes.defaultSpace),
                child: Column(
                  children: [
                    //RAting & Share Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //RAting
                        const TRatingAndShare(),

                        //Share Button
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.share, size: TSizes.iconMd))
                      ],
                    ),

                    TProductMetaData(product: product),

                    //Attributes
                    if(product.productType == ProductType.variable.toString()) TProductAttributes(product: product),
                    if(product.productType == ProductType.variable.toString()) const SizedBox(height: TSizes.spaceBtwSections),

                    //Checkout Button
                    SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, child: const Text('Checkout'))),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    //Description
                    const TSectionHeading(title: 'Description', showActionButton: false),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    ReadMoreText(
                      product.description ?? '',
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: ' Show More',
                      trimExpandedText: '  Less',
                      moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                      lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    ),

                    //Reviews
                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TSectionHeading(title: 'Reviews (199)', showActionButton: false),
                        IconButton(onPressed: () => Get.to(() => const ProductReviewScreen()), icon: const Icon(Iconsax.arrow_right_3))
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}



class TRatingAndShare extends StatelessWidget {
  const TRatingAndShare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Iconsax.star5, color: Colors.amber, size: 24),
        const SizedBox(width: TSizes.spaceBtwItems / 2),
        Text.rich(TextSpan(children: [
          TextSpan(text: '5.0', style: Theme.of(context).textTheme.bodyLarge),
          const TextSpan(text: '(199)'),
        ]))
      ],
    );
  }
}

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key, required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    final controller = Get.put(ImageController());
    final images = controller.getAllProductImages(product);

    return TCurvededgewidget(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            //Main Large Image
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
                child: Center(child: Obx(
                  () { 
                  final image = controller.selectedProductImage.value;
                      return GestureDetector(
                        onTap: () => controller.showEnlargedImage(image),
                        child: CachedNetworkImage(imageUrl: image,
                        progressIndicatorBuilder: (_, __, downloadProgress) => 
                        CircularProgressIndicator(value: downloadProgress.progress, color: TColors.primary)),
                      );
                    })),
              ),
            ),

            //Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: TSizes.spaceBtwItems),
                  itemCount: images.length,
                  itemBuilder: (_, index) => Obx(() {

                    final imageSelected = controller.selectedProductImage.value == images[index];

                    return TRoundedImage(
                      imageUrl: images[index],
                      isNetworkImage: true,
                      onPressed: () => controller.selectedProductImage.value = images[index],
                      width: 80,
                      backgroundColor: dark ? TColors.dark : TColors.white,
                      border: Border.all(color: imageSelected ? TColors.primary : Colors.transparent),
                      padding: const EdgeInsets.all(TSizes.sm));
                  })
                ),
              ),
            ),

            //AppBar
            TAppBar(
              showBackArrow: true,
              actions: [TFavouriteIcon(productId: product.id)],
            )
          ],
        ),
      ),
    );
  }
}



class TProductPriceText extends StatelessWidget {
  const TProductPriceText(
      {super.key,
      this.currencySign = '\$',
      required this.price,
      this.maxLines = 1,
      this.isLarge = false,
      this.lineThrough = false});

  final String currencySign, price;
  final int maxLines;
  final bool isLarge;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
      currencySign + price,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? Theme.of(context).textTheme.headlineMedium!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null)
          : Theme.of(context).textTheme.titleLarge!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null),
    );
  }
}



