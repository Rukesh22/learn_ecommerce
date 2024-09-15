import 'package:get/get.dart';
import 'package:learn_ecommerce/data/models/category_model.dart';
import 'package:learn_ecommerce/data/repositories/category_repository.dart';
import 'package:learn_ecommerce/utils/helpers/t_loader.dart';

class CategoryController extends GetxController{
  static CategoryController get instamce => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featureCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  //Load Category data
  Future<void> fetchCategories() async {
    try {
      //show the loader while loading categories
      isLoading.value = true;

      //fetch categories fom data source (Firestore, api, etc)
      final categories = await _categoryRepository.getAllCategories();

      //update the categories list
      allCategories.assignAll(categories);

      //Filter Featured categories
      featureCategories.assignAll(allCategories.where((category) => category.isFeatured && category.parentId.isEmpty).take(8).toList());

    } catch (e) {

      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      
    } finally {
      //remove loader
      isLoading.value = false;

    }
  }
}