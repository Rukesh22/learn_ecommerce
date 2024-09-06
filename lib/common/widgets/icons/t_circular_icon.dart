import 'package:flutter/material.dart';
import 'package:learn_ecommerce/utils/constants/colors.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:learn_ecommerce/utils/helpers/helper_functions.dart';

class TCIrcularIcon extends StatelessWidget {
  const TCIrcularIcon({
    super.key,
    this.onPressed, required this.icon,
    this.width,
    this.height,
    this.size = TSizes.lg, this.backgroundColor, this.color,
  });

 
  final VoidCallback? onPressed;
  final IconData icon;
  final Color? backgroundColor;
  final Color? color;
  final double? width, height, size;
  



  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor !=null
        ? backgroundColor!
        :THelperFunctions.isDarkMode(context)
        ? TColors.black.withOpacity(0.9)
        : TColors.white.withOpacity(0.9),
      ),
      child: IconButton(onPressed: onPressed ,icon:Icon(icon, color: color,size: size,)),
    );
  }
}

class TShadowStyle {
  static final verticalProductShadow = BoxShadow(
    color: TColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2)
  );

  static final horizontalProductShadow = BoxShadow(
    color: TColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2)
  );
}