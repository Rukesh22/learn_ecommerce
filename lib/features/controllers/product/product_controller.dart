import 'package:get/get.dart';
import 'package:learn_ecommerce/data/models/product_model.dart';
import 'package:learn_ecommerce/data/repositories/product_repository.dart';
import 'package:learn_ecommerce/utils/constants/enums.dart';
import 'package:learn_ecommerce/utils/helpers/t_loader.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  //Load Category data
  void fetchFeaturedProducts() async {
    try {
      //show the loader while loading categories
      isLoading.value = true;

      //fetch categories fom data source (Firestore, api, etc)
      final products = await productRepository.getFeaturedProducts();

      //update the categories list
      featuredProducts.assignAll(products);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //remove loader
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {

      //fetch products
      final products = await productRepository.getAllFeaturedProducts(); //to-do if wrong change this
      return products;
      
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    } 
  }

  //Get the product price or price range for vaiations
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;
    
    //if no variable exist rreturn the single price or sale price
    if(product.productType == ProductType.single.toString()){
      return (product.salePrice > 0 ? product.salePrice : product.price).toString();
    } else {
      //calculate the smallest and largest price amoing variations
      for(var variation in product.productVariations!){
        //determin ethe price to consider (sale price if available, othewise regular price)
        double pricetoConsider = variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        //update the smallest and largest price
        if(pricetoConsider < smallestPrice) {
          smallestPrice = pricetoConsider;
        }

        if(pricetoConsider > largestPrice) {
          largestPrice = pricetoConsider;
        }
      }

      //if smallest and largest prices ae the same, etuen a single price
        if(smallestPrice.isEqual(largestPrice)) {
          return largestPrice.toString();
        } else {
          //otherwise, returrn a proce range
          return '$smallestPrice - \$$largestPrice';
        }
    }
  }


  //Calculate discount percemtage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null  || salePrice <= 0.0) return null;
    if (originalPrice <=0 ) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  //check product stock status
  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In stock' : 'out of stock';
  }
}
