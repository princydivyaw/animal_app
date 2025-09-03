import 'package:animal_app/onboard/presentation/widgets/db_rain_drop_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:share_module/core/constants/app_routes.dart';
import 'package:share_module/core/constants/app_strings.dart';
import 'package:share_module/core/services/storage_services.dart';
import 'package:share_module/core/theme/text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String message = "Loading...";

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      checkUserDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(message, style: AppTextStyles.headingNormal())),
    );
  }

  Future<void> checkUserDetails() async {
    await DoHiveUtils.openHiveBox(hiveBoxName: AppStrings.appUserDetails);

    final userRegDetails = await DoHiveUtils.getHiveBox(
      hiveBoxName: AppStrings.appUserDetails,
      keyName: AppStrings.userRegDetails,
    );

    if (userRegDetails == null || userRegDetails.toString().isEmpty) {
      Modular.to.pushNamed("/${AppRoutes.login}");
    } else {
      Modular.to.push(
        MaterialPageRoute(
          builder: (_) => const DbRainDropAnimation(
            pageScreen: "${AppRoutes.dashboardModule}/",
          ),
        ),
      );
    }
  }
}
