import 'package:flutter/material.dart';
import 'package:learn_ecommerce/common/styles/boxes.shimmer.dart';
import 'package:learn_ecommerce/common/styles/list_tile_shimmer.dart';
import 'package:learn_ecommerce/data/models/category_model.dart';
import 'package:learn_ecommerce/features/controllers/product/brand_controller.dart';
import 'package:learn_ecommerce/features/screens/all_brands/brand_showcase.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:learn_ecommerce/utils/helpers/cloud_helper_functions.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
      future: controller.getBrandsForCategory(category.id), 
      builder: (context, snapshot) {
        //Handle Loader , no record, or error message
        const loader = Column(
          children: [
            TListTileShimmer(),
            SizedBox(height: TSizes.spaceBtwItems),
            TBoxesShimmer(),
            SizedBox(height: TSizes.spaceBtwItems),
          ],
        );

        final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
        if(widget != null) return widget;

        //Record Found
        final brands = snapshot.data!;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: brands.length,
          itemBuilder: (_, index) {
            final brand = brands[index];
            return FutureBuilder(
              future: controller.getBrandProducts(brandId: brand.id, limit: 3), 
              builder: (context, snapshot) {

                //Handle Loader, no record, or error message
                final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                if(widget != null) return widget;
                
                 //Record Found
                 final products = snapshot.data!;

                return TBrandShowcase(brand: brand, images: products.map((e) => e.thumbnail).toList());
              });

          });

        
      }
      );

    
  }
}