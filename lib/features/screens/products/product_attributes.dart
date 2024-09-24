import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_ecommerce/common/styles/rounded_container.dart';
import 'package:learn_ecommerce/features/screens/products/product_cards/profuctcard_vertical.dart';
import 'package:learn_ecommerce/common/widgets/layout/choice_chip.dart';
import 'package:learn_ecommerce/common/widgets/layout/t_sectionheading.dart';
import 'package:learn_ecommerce/data/models/product_model.dart';
import 'package:learn_ecommerce/features/controllers/product/variation_controller.dart';
import 'package:learn_ecommerce/features/screens/products/product_detail.dart';
import 'package:learn_ecommerce/utils/constants/colors.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:learn_ecommerce/utils/helpers/helper_functions.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());
    return Obx(
      () => Column(
        children: [
          if (controller.selectedVariation.value.id.isNotEmpty)
            TRoundedContainer(
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
              child: Column(
                children: [
                  //Title, Price & Stock Status
                  Row(
                    children: [
                      const TSectionHeading(
                          title: 'Variation', showActionButton: false),
                      const SizedBox(width: TSizes.spaceBtwItems),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const TProductTitleText(
                                  title: 'Price : ', smallSize: true),
      
                              //Actual Price
                              if (controller.selectedVariation.value.salePrice > 0)
                              Text('\$${controller.selectedVariation.value.price}',
                                style: Theme.of(context).textTheme
                                    .titleSmall!
                                    .apply(decoration: TextDecoration.lineThrough),
                              ),
                              const SizedBox(width: TSizes.spaceBtwItems),
      
                              //Sale Price
                              TProductPriceText(price: controller.getVariationPrice()),
                            ],
                          ),
      
                          //Stack
                          Row(
                            children: [
                              const TProductTitleText(title: 'Stock : ', smallSize: true),
                              Text(controller.variationStockStatus.value,style: Theme.of(context).textTheme.titleMedium),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
      
                  //Variation Description
                  TProductTitleText(
                      title: controller.selectedVariation.value.description ?? '',
                      smallSize: true,
                      maxLines: 4)
                ],
              ),
            ),
          const SizedBox(height: TSizes.spaceBtwItems),
      
          /// Attributes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map(
                  (attribute) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TSectionHeading(
                          title: attribute.name ?? '', showActionButton: false),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
      
                      Obx(
                        () => Wrap(
                            spacing: 8,
                            children: attribute.values!.map((attributevalue) {
                              final isSelected = controller.selectedAttributes[attribute.name] == attributevalue;
                              final available = controller
                                  .getAttributesAvalabilityInVariation(product.productVariations!, attribute.name!)
                                  .contains(attributevalue);
                        
                              return TChoiceChip(
                                  text: attributevalue,
                                  selected: isSelected,
                                  onSelected: available ? (selected) {
                                    if (selected && available) {
                                      controller.onAttributeSelected(product, attribute.name ?? '', attributevalue);
                                    }
                                  } : null);
                            }).toList()),
                      )
                    ],
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
