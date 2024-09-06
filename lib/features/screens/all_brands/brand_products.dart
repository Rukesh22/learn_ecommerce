import 'package:flutter/material.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/appbar.dart';
import 'package:learn_ecommerce/features/screens/all_products/sortable/soratbel_products.dart';
import 'package:learn_ecommerce/features/screens/store.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TAppBar(title: Text('Nike'), showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            //Brand Detail
            TBrandCard(showBorder: true),
            SizedBox(height: TSizes.spaceBtwSections),

            TSortableProducts(),
          ],
        ),),
      ),
    );
  }
}