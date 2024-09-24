import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/appbar.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/vertical_product_shimmer.dart';
import 'package:learn_ecommerce/common/widgets/icons/t_circular_icon.dart';
import 'package:learn_ecommerce/common/widgets/layout/gridview.dart';
import 'package:learn_ecommerce/data/models/product_model.dart';
import 'package:learn_ecommerce/features/controllers/product/favourite_controller.dart';
import 'package:learn_ecommerce/features/screens/home/home.dart';
import 'package:learn_ecommerce/features/screens/products/product_cards/profuctcard_vertical.dart';

import 'package:learn_ecommerce/utils/constants/colors.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:learn_ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:learn_ecommerce/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = FavouriteController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          TCIrcularIcon(icon: Iconsax.add, onPressed: () => Get.to(HomeScreen())),
        ],
      ),

      //body
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),

        //products grid

        child: FutureBuilder(
          future: controller.favouriteProducts(), 
          builder: (context, snapshot) {

            const loader = TVerticalProductShimmer(itemCount: 6);
            final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader, nothingFound: emptyWidget);
            if(widget!= null) return widget;

            return TGridLayout(
            itemCount: 6, 
            itemBuilder: (_, index) => TProductCardVertical(product: ProductModel.empty()));
          }),),
      ),
    );
  }
}