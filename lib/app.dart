import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_ecommerce/bindings/general_bindings.dart';
import 'package:learn_ecommerce/features/screens/onboarding.dart';
import 'package:learn_ecommerce/utils/constants/colors.dart';
import 'package:learn_ecommerce/utils/constants/text_strings.dart';
import 'package:learn_ecommerce/utils/helpers/network_manager.dart';
import 'package:learn_ecommerce/utils/theme/theme.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const Scaffold(backgroundColor: TColors.primary, body: Center(child: CircularProgressIndicator(color: Colors.white)),)
    );
  }
}

class DependencyUnjection {
  static void init() {
    Get.put<NetworkManager>(NetworkManager(), permanent: true);
  }
}