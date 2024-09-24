

import 'package:get/get.dart';
import 'package:learn_ecommerce/data/models/product_model.dart';
import 'package:learn_ecommerce/data/models/product_vaiation.model.dart';
import 'package:learn_ecommerce/features/controllers/product/image_controller.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  //variables
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation = ProductVariationModel.empty().obs;

  //select attributes and variation
  void onAttributeSelected(ProductModel product, attributeName, attributeValue) {
    //when attribute is selected we will first add that attribute to the selectedAttributes
    final selectedAttributes = Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    final selectedVariation = product.productVariations!.firstWhere(
      (variation) => _isSameAttributeValues(variation.attributeValues, selectedAttributes),
      orElse: () => ProductVariationModel.empty(),
    );

    //show the selected vaiation image as a main image
    if (selectedVariation.image.isNotEmpty) {
      ImageController.instance.selectedProductImage.value = selectedVariation.image;
    }

    //assign selected varaition
    this.selectedVariation.value = selectedVariation;

    //update selectde product variation status
    getProductVariationStockStatus();
  }


  //check if seleted attributes matches any validation attributes
  bool _isSameAttributeValues(Map<String, dynamic> variationAttributes, Map<String, dynamic> selectedAttributes) {
    // if selctedAttributes containes 3 attrubutes and current variation contains 2 then return
    if(variationAttributes.length != selectedAttributes.length) return false;

    //if any of the attributes is different from return eg [Green, large] * [Green, Small]
    for(final key in variationAttributes.keys) {
      // Attributes[Key] = value which could be [Green, small, cotton] etc
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }
    return true;
  }


  //Check attribute availability / stock in variation
  Set<String?> getAttributesAvalabilityInVariation(List<ProductVariationModel> variations, String attributeName) {
    //pass the variations to check which attributes are avaible and stock is not 0
    final availableVariationAttributesValues = variations.where((variation) =>
    //check empty / out of stock attributes
    variation.attributeValues[attributeName] != null && variation.attributeValues[attributeName]!.isNotEmpty && variation.stock > 0)
    //Fetch all non empty attributes of vaiations
    .map((variation) => variation.attributeValues[attributeName]).toSet();

    return availableVariationAttributesValues;
  }

  String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0 ? selectedVariation.value.salePrice : selectedVariation.value.price).toString();
  }

  //check product variatio stock status
  void getProductVariationStockStatus() {
    variationStockStatus.value = selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  //reset selected attributes when switching poducts
  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }
}