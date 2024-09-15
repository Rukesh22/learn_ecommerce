


import 'package:get/get.dart';
import 'package:learn_ecommerce/data/models/banner_mode.dart';
import 'package:learn_ecommerce/data/repositories/banner_repository.dart';
import 'package:learn_ecommerce/utils/helpers/t_loader.dart';

class BannerController extends GetxController{

  //vaiables
  final isLoading = false.obs;
  final carouselCurentIndex = 0.obs;
  final RxList<BannerMode> banners = <BannerMode>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  // Update page navigational data
  void updatePageIndicator(index) {
    carouselCurentIndex.value = index;
  }

  //Fetch Banners
  Future<void> fetchBanners() async {
    try {
      //show the loader while loading categories
      isLoading.value = true;

      //Fetch Banners
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      //assign banners
     this.banners.assignAll(banners);

    } catch (e) {

      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      
    } finally {
      //remove loader
      isLoading.value = false;

    }
  }
}