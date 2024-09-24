import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/appbar.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/vertical_product_shimmer.dart';
import 'package:learn_ecommerce/data/models/product_model.dart';
import 'package:learn_ecommerce/features/controllers/product/allproduct_controller.dart';
import 'package:learn_ecommerce/features/screens/all_products/sortable/soratbel_products.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:learn_ecommerce/utils/helpers/cloud_helper_functions.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    //initilize controller for managing product fetching
    final controller = Get.put(AllProductController());
    return Scaffold(
      appBar: TAppBar(title: Text(title),showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: FutureBuilder(
          future: futureMethod ?? controller.fetchProductsByQuery(query), 
          builder: (context, snapshot) {
            //check the state of the futherbuilder snapshot
            const loader = TVerticalProductShimmer();

            final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);

            //return appropriate widget based on snashot state
            if(widget != null) return widget;

            //products found
            final products = snapshot.data!;

            return TSortableProducts(products: products);
          }),
        ),
      ),
    );
  }
}

