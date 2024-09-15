import 'package:learn_ecommerce/data/models/banner_mode.dart';
import 'package:learn_ecommerce/data/models/brand_model.dart';
import 'package:learn_ecommerce/data/models/product_attribute_model.dart';
import 'package:learn_ecommerce/data/models/product_model.dart';
import 'package:learn_ecommerce/data/models/product_vaiation.model.dart';

import 'package:learn_ecommerce/utils/constants/image_strings.dart';
import 'package:learn_ecommerce/utils/routes/routes.dart';

class TDummyData {
  //Bannes
  static final List<BannerMode> banners = [
    BannerMode(targetScreen: TRoutes.order, active: false, imageUrl: TImages.banner1)
  ];

  //List of all products
  static final List<ProductModel> products = [
    ProductModel(
      id: '001',
      title: 'Green Nike Sport Shoe', 
      stock: 15, 
      price: 135, 
      isFeatured: true,
      thumbnail: TImages.productImage1, 
      description: 'Greem Nike sport shoe',
      brand: BrandModel(id: '1', image: TImages.nikeLogo, name:'Nike', productsCount: 265, isFeatured: true),
      images: [TImages.productImage1, TImages.productImage23, TImages.productImage21, TImages.productImage9],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '1',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Green', 'Black', 'Red']),
        ProductAttributeModel(name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1', 
          stock: 34,
          price: 134,
          salePrice: 122.6,
          image: TImages.productImage1,
          description: 'This is a product description for green nike sports sjhoe',
          attributeValues: {'Color': 'Green', 'Size': 'EU 34'}),

          ProductVariationModel(
          id: '2', 
          stock: 10,
          price: 134,
          salePrice: 122.6,
          image: TImages.productImage23,
          description: 'This is a product description for green nike sports sjhoe',
          attributeValues: {'Color': 'Green', 'Size': 'EU 32'}),

          ProductVariationModel(
          id: '3', 
          stock: 3,
          price: 114,
          salePrice: 122.6,
          image: TImages.productImage23,
          description: 'This is a product description for green nike sports sjhoe',
          attributeValues: {'Color': 'Green', 'Size': 'EU 34'}),

           ProductVariationModel(
          id: '4', 
          stock: 0,
          price: 134,
          salePrice: 122.6,
          image: TImages.productImage1,
          description: 'This is a product description for green nike sports sjhoe',
          attributeValues: {'Color': 'Green', 'Size': 'EU 34'}),
      ], 
      productType: 'ProductType.variable'
      ),

      ProductModel(
      id: '002',
      title: 'Blue Tshirt for all ages', 
      stock: 15, 
      price: 135, 
      isFeatured: true,
      thumbnail: TImages.productImage69, 
      description: 'Greem Nike sport shoe',
      brand: BrandModel(id: '6', image: TImages.zaraLogo, name:'Zara'),
      images: [TImages.productImage68, TImages.productImage69, TImages.productImage5],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '16',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Green', 'Black', 'Red']),
        ProductAttributeModel(name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
      ],
      productType: 'ProductType.single'
      )
  ];
}