import 'package:flutter/material.dart';
import 'package:learn_ecommerce/common/styles/rounded_container.dart';
import 'package:learn_ecommerce/features/screens/products/product_cards/profuctcard_vertical.dart';
import 'package:learn_ecommerce/common/widgets/layout/t_brandtext_icon.dart';
import 'package:learn_ecommerce/common/widgets/layout/t_circularimage.dart';
import 'package:learn_ecommerce/data/models/product_model.dart';
import 'package:learn_ecommerce/features/controllers/product/product_controller.dart';
import 'package:learn_ecommerce/features/screens/products/product_detail.dart';
import 'package:learn_ecommerce/utils/constants/colors.dart';
import 'package:learn_ecommerce/utils/constants/enums.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:learn_ecommerce/utils/helpers/helper_functions.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Price & Sale Price
        Row(
          children: [
            //Sale TAg
            TRoundedContainer(
                radius: TSizes.sm,
                backgroundColor: TColors.secondary.withOpacity(0.8),
                padding: const EdgeInsets.symmetric(
                    horizontal: TSizes.sm, vertical: TSizes.xs),
                child: Text(
                  '$salePercentage%',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: TColors.black),
                )),
            const SizedBox(width: TSizes.spaceBtwItems),

            //Price
            if(product.productType == ProductType.single.toString() && product.salePrice > 0)
              Text('\$${product.price}',style: Theme.of(context).textTheme.labelLarge!.apply(decoration: TextDecoration.lineThrough)),
            if(product.productType == ProductType.single.toString() && product.salePrice > 0) const SizedBox(width: TSizes.spaceBtwItems),
            TProductPriceText(price: controller.getProductPrice(product), isLarge: true),
          ],
        ),
        const SizedBox(width: TSizes.spaceBtwItems / 1.5),

        //Title
        TProductTitleText(title: product.title),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),


        //Stock Status
        Row(
          children: [
            const TProductTitleText(title: 'Status'),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(controller.getProductStockStatus(product.stock), style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(width: TSizes.spaceBtwItems / 1.5),

        //Brand
        Row(
          children: [
            TCircularImage(
            image: product.brand != null ? product.brand!.image : '',
            width: 32,
            height: 32,
            overlayColor: dark ? TColors.white : TColors.black),
            TBrandTitleWithVerifyIcon(title: product.brand != null ? product.brand!.name : '', brandTextSize: TextSizes.medium)
          ],
        )

      ],
    );
  }
}