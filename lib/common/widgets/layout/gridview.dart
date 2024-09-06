import 'package:flutter/material.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';

class TGridLayout extends StatelessWidget {
  const TGridLayout({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.mainAxisExtent = 288
  
  });

  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;
  final double? mainAxisExtent;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
    itemCount: itemCount,
    shrinkWrap: true,
    padding: EdgeInsets.zero,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: TSizes.gridViewSpacing,
    crossAxisSpacing: TSizes.gridViewSpacing,
    mainAxisExtent: mainAxisExtent
    ),
    itemBuilder: itemBuilder,
    );
  }
}