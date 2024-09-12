import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/appbar.dart';
import 'package:learn_ecommerce/common/widgets/layout/t_circularimage.dart';
import 'package:learn_ecommerce/common/widgets/layout/t_sectionheading.dart';
import 'package:learn_ecommerce/features/controllers/user/user_controller.dart';
import 'package:learn_ecommerce/features/screens/profile/change_name.dart';
import 'package:learn_ecommerce/utils/constants/image_strings.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learn_ecommerce/utils/theme/widget_themes/shimmer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Profile')
      ),

      // Body 
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            //Profile Picture
            SizedBox(width: double.infinity,
            child: Column(
              children: [
                Obx(() {
                final networkImage = controller.user.value.profilePicture;
                final image = networkImage.isNotEmpty ? networkImage : TImages.user;
                return controller.imageUploading.value 
                ? const TShimmerEffect(width: 80, height: 80, radius: 80) 
                : TCircularImage(image: image, width: 80, height: 80, isNetworkImage: networkImage.isNotEmpty);
                }),
                TextButton(onPressed: () => controller.uploadUserProfilePicture(), child: const Text('Change Profile Picture')),

              ],
            ),
            ),

            ///Details 
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            const Divider(),
            const SizedBox(height: TSizes.spaceBtwItems),

            //Heading Profile Info
            const TSectionHeading(title: 'Profile Information', showActionButton: false),
            const SizedBox(height: TSizes.spaceBtwItems),

            TProfileMenu(title: 'Name', value: controller.user.value.fullName, onPressed: () => Get.to(() => const ChangeName())),
            TProfileMenu(title: 'Username', value: controller.user.value.username, onPressed: () {}),

            const SizedBox(height: TSizes.spaceBtwItems),
            const Divider(),
            const SizedBox(height: TSizes.spaceBtwItems),

            //Heading Personal Info
            const TSectionHeading(title: 'Profile Information', showActionButton: false),
            const SizedBox(height: TSizes.spaceBtwItems),

            TProfileMenu(title: 'User ID', value: controller.user.value.id,icon: Iconsax.copy ,onPressed: () {}),
            TProfileMenu(title: 'E-Mail', value: controller.user.value.email, onPressed: () {}),
            TProfileMenu(title: 'Phone Number', value: controller.user.value.phoneNumber, onPressed: () {}),
            TProfileMenu(title: 'Gender', value: 'Male', onPressed: () {}),
            TProfileMenu(title: 'Date of Birth', value: '29 Dec, 2002', onPressed: () {}),
            const Divider(),
            const SizedBox(height: TSizes.spaceBtwItems),

            Center(
              child: TextButton(onPressed: () => controller.deleteAccountWarningPopup(), child: const Text('Close Account', style: TextStyle(color: Colors.red))),
            )
            
          ],
        ),),
      ),
    );
  }
}

class TProfileMenu extends StatelessWidget {
  const TProfileMenu({
    super.key, this.icon = Iconsax.arrow_right_34, required this.onPressed, required this.title, required this.value,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String title, value;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwItems / 1.5),
        child: Row(
          children: [
            Expanded(flex:3,child:  Text(title, style: Theme.of(context).textTheme.bodySmall, overflow: TextOverflow.ellipsis)),
            Expanded(flex:5,child:  Text(value, style: Theme.of(context).textTheme.bodyMedium, overflow: TextOverflow.ellipsis)),
            const Expanded(child: Icon(Iconsax.arrow_right_34, size: 18)),
          ],
        ),
      ),
    );
  }
}