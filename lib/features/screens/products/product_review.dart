import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:learn_ecommerce/common/styles/rounded_container.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/appbar.dart';
import 'package:learn_ecommerce/utils/constants/colors.dart';
import 'package:learn_ecommerce/utils/constants/image_strings.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:learn_ecommerce/utils/device/device_utility.dart';
import 'package:learn_ecommerce/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App Bar
      appBar: const TAppBar(title: Text('Review & Ratings'), showBackArrow: true),

      /// Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Ratings and reviews are verified and are from people who uses the same type of device that you use.'),
              const SizedBox(height: TSizes.spaceBtwItems),

              //Overall Product Ratings
              const TOverAllProductRating(),
              const TRatingBarIndicator(rating: 3.5),
              Text('12,611', style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: TSizes.spaceBtwSections),

              //User Review List
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),

            ],
          ),
        ),
      ),
    );
  }
}

class TOverAllProductRating extends StatelessWidget {
  const TOverAllProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 3,
            child:
                Text('4.8', style: Theme.of(context).textTheme.displayLarge)),
        const Expanded(
            flex: 7,
            child: Column(
              children: [
                TRAtingProgressIndicator(text: '5', value: 1.0),
                TRAtingProgressIndicator(text: '4', value: 0.8),
                TRAtingProgressIndicator(text: '3', value: 0.6),
                TRAtingProgressIndicator(text: '2', value: 0.4),
                TRAtingProgressIndicator(text: '1', value: 0.2),
              ],
            ))
      ],
    );
  }
}

class TRAtingProgressIndicator extends StatelessWidget {
  const TRAtingProgressIndicator({
    super.key,
    required this.text,
    required this.value,
  });
  final String text;
  final double value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
        Expanded(
            flex: 11,
            child: SizedBox(
              width: TDeviceUtils.getScreenWidth(context) * 0.8,
              child: LinearProgressIndicator(
                value: value,
                minHeight: 11,
                backgroundColor: TColors.grey,
                borderRadius: BorderRadius.circular(7),
                valueColor: const AlwaysStoppedAnimation(TColors.primary),
              ),
            ))
      ],
    );
  }
}

class TRatingBarIndicator extends StatelessWidget {
  const TRatingBarIndicator({super.key, required this.rating});
  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
        rating: rating,
        itemSize: 20,
        unratedColor: TColors.grey,
        itemBuilder: (_, __) => const Icon(
              Iconsax.star1,
              color: TColors.primary,
            ));
  }
}

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                    backgroundImage: AssetImage(TImages.userProfileImage1)),
                const SizedBox(height: TSizes.spaceBtwItems),
                Text('Rukesh', style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        //Review
        Row(
          children: [
            const TRatingBarIndicator(rating: 4),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text('29 Dec 2024', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        const ReadMoreText(
          'The User Interface of the app is quiet intuitive. I was able to naviagate and make purchases seamlessly. Graet job!',
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimCollapsedText: ' Show More',
          trimExpandedText: '  Less',
          moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
          lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// Company REview
        TRoundedContainer(
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Padding(padding: const EdgeInsets.all(TSizes.md),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("T's Store", style: Theme.of(context).textTheme.titleMedium),
                  Text('02 nov 2024', style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
        const ReadMoreText(
          'The User Interface of the app is quiet intuitive. I was able to naviagate and make purchases seamlessly. Graet job!',
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimCollapsedText: ' Show More',
          trimExpandedText: '  Less',
          moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
          lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
        ),
            ],
          ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems)
      ],
    );
  }
}
