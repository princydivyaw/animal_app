import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:share_module/core/constants/app_routes.dart';

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
      Modular.to.pushNamed("/${AppRoutes.login}");
      // Modular.to.pushNamed("${AppRoutes.dashboardModule}/");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(message)));
  }
}
