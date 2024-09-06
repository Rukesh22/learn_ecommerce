import 'package:flutter/material.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/appbar.dart';
import 'package:learn_ecommerce/features/screens/order/widgets/order_list.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';

class OrderScreen extends StatelessWidget {
  // ignore: use_super_parameters
  const OrderScreen({Key ? key}) : super(key : key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //App Bar
      appBar: TAppBar( showBackArrow: true, title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall)),
      body: const Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
      
      // Orders
      child: TOrderListItems()),
    );
  }
}