import 'package:flutter/material.dart';
import 'package:learn_ecommerce/common/styles/rounded_container.dart';
import 'package:learn_ecommerce/common/widgets/icons/t_circular_icon.dart';
import 'package:learn_ecommerce/common/widgets/layout/t_brandtext_icon.dart';
import 'package:learn_ecommerce/common/widgets/layout/t_rounded_image.dart';
import 'package:learn_ecommerce/data/models/product_model.dart';
import 'package:learn_ecommerce/features/controllers/product_controller.dart';
import 'package:learn_ecommerce/features/screens/product_detail.dart';
import 'package:learn_ecommerce/utils/constants/colors.dart';
import 'package:learn_ecommerce/utils/constants/enums.dart';
import 'package:learn_ecommerce/utils/constants/image_strings.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:learn_ecommerce/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.white,
        ),
        child: Column(
          children: [
            TRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  //Thumbnail Image
                  TRoundedImage(
                      imageUrl: product.thumbnail, applyImageRadius: true, isNetworkImage: true),

                  //SaleTAg
                  Positioned(
                    top: 12,
                    child: TRoundedContainer(
                      radius: TSizes.sm,
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm, vertical: TSizes.xs),
                      child: Text('$salePercentage%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: TColors.black),
                      ),
                    ),
                  ),

                  //Favourite Icon Button
                  const Positioned(top:0, right: 0,child:  TCIrcularIcon(icon: Iconsax.heart5, color: Colors.red))
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),

            //Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TProductTitleText(title: product.title, smallSize: true),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    TBrandTitleWithVerifyIcon(title: product.brand!.name)
                    
                  ],
                ),
              ),
            ),

            const Spacer(),

            //Price Row
            Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [


                      //Price
                      Flexible(
                        child: Column(
                          children: [
                            if(product.productType == ProductType.single.toString() && product.salePrice > 0)
                            Padding(
                            padding: const EdgeInsets.only(left: TSizes.sm),
                            child: Text(
                              product.price.toString(),
                              style: Theme.of(context).textTheme.labelMedium!.apply(decoration: TextDecoration.lineThrough),
                            )),

                            Padding(
                            padding: const EdgeInsets.only(left: TSizes.sm),
                            child: TProductPriceText(price: controller.getProductPrice(product))),
                          ],
                        ),
                      ),

                      //Add to cart Button
                      Container(
                        decoration: const BoxDecoration(
                          color: TColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(TSizes.cardRadiusMd),
                            bottomRight:
                                Radius.circular(TSizes.productImageRadius),
                          ),
                        ),
                        child: const SizedBox(
                          width: TSizes.iconLg * 1.2,
                          height: TSizes.iconLg * 1.2,
                          child: Center(
                              child: Icon(Iconsax.add, color: TColors.white)),
                        ),
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}


class TProductTitleText extends StatelessWidget {
  const TProductTitleText(
      {super.key,
      required this.title,
      this.smallSize = false,
      this.maxLines = 2,
      this.textAlign = TextAlign.left});

  final String title;
  final bool smallSize;
  final int maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: smallSize
          ? Theme.of(context).textTheme.labelLarge
          : Theme.of(context).textTheme.titleSmall,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}


class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
        width: 310,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.softGrey,
        ),
        child: Row(
          children: [
            //Thumbnail
            TRoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.white,
              child: Stack(
                children: [
                  //Thumbnail Image
                  const SizedBox(
                    height: 120,
                    width: 120,
                    child: TRoundedImage(imageUrl: TImages.productImage2, applyImageRadius: true),
                  ),

                  //SaleTAg
                  Positioned(
                    top: 12,
                    child: TRoundedContainer(
                      radius: TSizes.sm,
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm, vertical: TSizes.xs),
                      child: Text(
                        '25%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: TColors.black),
                      ),
                    ),
                  ),

                  //Favourite Icon Button
                  const Positioned(top:0, right: 0,child:  TCIrcularIcon(icon: Iconsax.heart5, color: Colors.red))
                ],
              ),
            ),

            //Details
            SizedBox(
              width: 172,
              child: Padding(padding:const EdgeInsets.only(top: TSizes.sm, left: TSizes.sm),
              child: Column(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TProductTitleText(title: 'Green Nike Half Sleeves Shirt', smallSize: true),
                      SizedBox(height: TSizes.spaceBtwItems / 2),
                      TBrandTitleWithVerifyIcon(title: 'Nike'),
                    ],
                  ),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Price
                      const Padding(padding: EdgeInsets.only(left: TSizes.sm),
                      child: TProductPriceText(price: '35.0'),
                      ),
                      

                      //Add to Cart
                      Container(
                        decoration: const BoxDecoration(
                          color: TColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(TSizes.cardRadiusMd),
                            bottomLeft: Radius.circular(TSizes.productImageRadius)
                          )
                        ),
                        child: const SizedBox(
                          width: TSizes.iconLg * 1.2,
                          height: TSizes.iconLg * 1.2,
                          child: Center(child: Icon(Iconsax.add, color: TColors.white)),
                        ),
                      ),

                    ],
                  )
                ],
              ),
              ),
            )
          ],
        ),
        );
  }
}