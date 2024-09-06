import 'package:flutter/material.dart';
import 'package:learn_ecommerce/utils/constants/colors.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:learn_ecommerce/utils/device/device_utility.dart';
import 'package:learn_ecommerce/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({super.key, required this.text, this.icon = Iconsax.search_normal, this.onTap,this.showBackground = true, this.showBorder = true,
  this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace)});

  final String text;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool showBackground, showBorder;
  final EdgeInsetsGeometry padding;


  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
                            onTap: onTap,
                            child: Padding(
                              padding: padding,
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
                          );

  }
}