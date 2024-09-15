import 'package:get/get.dart';
import 'package:learn_ecommerce/features/screens/address/address.dart';
import 'package:learn_ecommerce/features/screens/cart/cartScreen.dart';
import 'package:learn_ecommerce/features/screens/checkout/checkout.dart';
import 'package:learn_ecommerce/features/screens/home/home.dart';
import 'package:learn_ecommerce/features/screens/login/login.dart';
import 'package:learn_ecommerce/features/screens/onboarding.dart';
import 'package:learn_ecommerce/features/screens/order/order_screen.dart';
import 'package:learn_ecommerce/features/screens/password/forget_password.dart';
import 'package:learn_ecommerce/features/screens/product_review.dart';
import 'package:learn_ecommerce/features/screens/profile/profilescreen.dart';
import 'package:learn_ecommerce/features/screens/settings.dart';
import 'package:learn_ecommerce/features/screens/signup/signup.dart';
import 'package:learn_ecommerce/features/screens/signup/verify_email.dart';
import 'package:learn_ecommerce/features/screens/store.dart';
import 'package:learn_ecommerce/features/screens/wishlist.dart';
import 'package:learn_ecommerce/utils/routes/routes.dart';

class AppRoutes {

static final pages = [

GetPage(name: TRoutes.home, page: () => HomeScreen()),

GetPage(name: TRoutes.store, page: () => const StoreScreen()),

GetPage(name: TRoutes.favourites, page: () => const FavouriteScreen()), GetPage(name: TRoutes.settings, page: () => const SettingsScreen()),

GetPage(name: TRoutes.productReviews, page: () => const ProductReviewScreen()),

GetPage(name: TRoutes.order, page: () => const OrderScreen()),

GetPage(name: TRoutes.checkout, page: () => const CheckoutScreen()),

GetPage(name: TRoutes.cart, page: () => const Cartscreen()),

GetPage(name: TRoutes.userProfile, page: () => const ProfileScreen()),

GetPage(name: TRoutes.userAddress, page: () => const UserAddressScreen()),

GetPage(name: TRoutes.signup, page: () => const SignupScreen()),

GetPage(name: TRoutes.verifyEmail, page: () => const VerifyEmailScreen()),  //check this paameters

GetPage(name: TRoutes.signIn, page: () => const LoginScreen()),

GetPage(name: TRoutes.forgetPassword, page: () => const ForgetPassword()),

GetPage(name: TRoutes.onBoarding, page: () => const OnBoardingScreen()),

// Add more GetPage entries as needed

];
}