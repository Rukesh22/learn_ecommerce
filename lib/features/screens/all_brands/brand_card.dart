import 'package:flutter/material.dart';
import 'package:learn_ecommerce/common/styles/rounded_container.dart';
import 'package:learn_ecommerce/common/widgets/layout/t_brandtext_icon.dart';
import 'package:learn_ecommerce/common/widgets/layout/t_circularimage.dart';
import 'package:learn_ecommerce/data/models/brand_model.dart';
import 'package:learn_ecommerce/utils/constants/colors.dart';
import 'package:learn_ecommerce/utils/constants/enums.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:learn_ecommerce/utils/helpers/helper_functions.dart';

class TBrandCard extends StatelessWidget {
  const TBrandCard({super.key, this.onTap, required this.showBorder, required this.brand});

  final bool showBorder;
  final void Function()? onTap;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Icon
            Flexible(
              child: TCircularImage(
                  isNetworkImage: true,
                  image: brand.image,
                  backgroundColor: Colors.transparent,
                  overlayColor: isDark ? TColors.white : TColors.black),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),

            //Text
            //[Expanded] and column [MainAxisSize.min] is important to keep the elements in the vertical centre and also
            //to keep text inside the boundaries

            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TBrandTitleWithVerifyIcon(title: brand.name, brandTextSize: TextSizes.large),
                  Text('${brand.productsCount ?? 0} products',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelMedium),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}