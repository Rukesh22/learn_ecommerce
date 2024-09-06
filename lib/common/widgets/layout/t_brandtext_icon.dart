import 'package:flutter/material.dart';
import 'package:learn_ecommerce/utils/constants/colors.dart';
import 'package:learn_ecommerce/utils/constants/enums.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class TBrandTitleWithVerifyIcon extends StatelessWidget {
  const TBrandTitleWithVerifyIcon({
    super.key, required this.title, this.maxLines = 1, this.textColor, this.iconColor =TColors.primary, this.textAlign = TextAlign.center, this.brandTextSize = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: TBrandTitleText(
            title: title,
            color: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
            brandTextSize: brandTextSize
          ),
        ),
    
        const SizedBox(width: TSizes.xs),
        Icon(Iconsax.verify5,
            color: iconColor, size: TSizes.iconXs),
      ],
    );
  }
}

class TBrandTitleText extends StatelessWidget {
  const TBrandTitleText({
    super.key, required this.title, this.maxLines = 1, this.color, this.textAlign = TextAlign.center,this.brandTextSize = TextSizes.small,
  });
  final String title;
  final int maxLines;
  final Color? color;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: brandTextSize == TextSizes.small
      ? Theme.of(context).textTheme.labelMedium!.apply(color: color)
      : brandTextSize == TextSizes.large
      ? Theme.of(context).textTheme.titleLarge!.apply(color: color)
      : Theme.of(context).textTheme.bodyMedium!.apply(color: color),
    );
  }
}
