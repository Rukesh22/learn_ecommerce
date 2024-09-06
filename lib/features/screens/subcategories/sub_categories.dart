import 'package:flutter/material.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/appbar.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/profuctcard.dart';
import 'package:learn_ecommerce/common/widgets/layout/t_sectionheading.dart';
import 'package:learn_ecommerce/features/screens/home.dart';
import 'package:learn_ecommerce/utils/constants/image_strings.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(title: Text('Sports'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            //Banner
            const TRoundedImage(width: double.infinity, imageUrl: TImages.banner3, applyImageRadius: true),
            const SizedBox(height: TSizes.spaceBtwSections),

            //Sub Categories
            Column(
              children: [
                //Heading
                TSectionHeading(title: 'Sports shirts', onPressed: (){}),
                const SizedBox(height: TSizes.spaceBtwItems / 2),

                SizedBox(
                  height: 120,
                  child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => const TProductCardHorizontal(),
                  separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems),
                  itemCount: 4),
                )
              ],
            )
          ],
        ),
        ),
      ),
    );
  }
}