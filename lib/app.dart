import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:learn_ecommerce/bindings/general_bindings.dart';
import 'package:learn_ecommerce/features/screens/onboarding.dart';
import 'package:learn_ecommerce/navigation_menu.dart';
import 'package:learn_ecommerce/utils/constants/text_strings.dart';
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
      initialBinding: GeneralBindings(),
      home: const OnBoardingScreen()
    );
  }
}
