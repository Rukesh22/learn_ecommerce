import 'package:flutter/material.dart';
import 'package:learn_ecommerce/common/widgets/layout/t_circularimage.dart';
import 'package:learn_ecommerce/utils/constants/colors.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:learn_ecommerce/utils/helpers/helper_functions.dart';

class TverticalImageText extends StatelessWidget {
  const TverticalImageText({super.key, 
  this.textColor = TColors.white, 
  required this.image, 
  required this.title, 
  this.backgroundColor, 
  this.isNetworkImage = true, 
  this.onTap});

  final Color textColor;
  final String image, title;
  final Color? backgroundColor;
  final bool isNetworkImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
      child: Column(
        children: [

          //circular icon
          TCircularImage(
            image: image,
            fit: BoxFit.fitWidth,
            padding: TSizes.sm * 1.4,
            isNetworkImage: isNetworkImage,
            backgroundColor: backgroundColor,
            overlayColor: THelperFunctions.isDarkMode(context) ? TColors.light : TColors.dark),

            //Text
                    const SizedBox(height:TSizes.spaceBtwItems / 2),
                    SizedBox(width: 55,
                    child: Text(title, style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .apply(color: TColors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis))

        ],
      ),),
    );
  }
}