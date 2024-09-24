import 'package:flutter/material.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/appbar.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/vertical_product_shimmer.dart';
import 'package:learn_ecommerce/data/models/brand_model.dart';
import 'package:learn_ecommerce/features/controllers/product/brand_controller.dart';
import 'package:learn_ecommerce/features/screens/all_brands/brand_card.dart';
import 'package:learn_ecommerce/features/screens/all_products/sortable/soratbel_products.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:learn_ecommerce/utils/helpers/cloud_helper_functions.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: TAppBar(title: Text(brand.name), showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            //Brand Detail
            TBrandCard(showBorder: true, brand: brand),
            const SizedBox(height: TSizes.spaceBtwSections),

            FutureBuilder(
              future: controller.getBrandProducts(brandId:brand.id), 
              builder: (context, snapshot) {

                //Handle Loader, no record, or error Message
                const loader = TVerticalProductShimmer();
                final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                if(widget != null) return widget;

                //Record found
                final brandProducts = snapshot.data!;
                return TSortableProducts(products: brandProducts);
              })
          ],
        ),),
      ),
    );
  }
}