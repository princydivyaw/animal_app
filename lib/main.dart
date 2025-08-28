import 'package:animal_app/onboard/presentation/pages/auth_screen.dart';
import 'package:animal_app/onboard/presentation/pages/splash_screen.dart';
import 'package:dashboard_module/dashboard_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:share_module/core/constants/app_routes.dart';
import 'package:share_module/core/constants/app_strings.dart';
import 'package:share_module/core/services/storage_services.dart';
import 'package:share_module/core/theme/app_theme.dart';

import 'onboard/data/datasources/ob_datasources.dart';
import 'onboard/data/repositories/ob_repository_impl.dart';
import 'onboard/domain/repositories/ob_repositories.dart';
import 'onboard/domain/usecases/ob_usecases.dart';
import 'onboard/presentation/cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await DoHiveUtils.openHiveBox(hiveBoxName: "UserDetails");
  runApp(ModularApp(module: AppModule(), child: const AnimalApp()));
}

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton<ObDataSource>((i) => ObDataSourceImpl()),
    Bind.singleton<ObRepository>(
      (i) => ObRepositoryImpl(obDataSource: i<ObDataSource>()),
    ),
    Bind.singleton<ObUseCase>(
      (i) => ObUseCase(obRepository: i<ObRepository>()),
    ),
    Bind.singleton<AuthCubit>((i) => AuthCubit(i<ObUseCase>())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(
      AppRoutes.splash,
      transition: TransitionType.fadeIn,
      child: (context, args) => const SplashScreen(),
    ),
    ChildRoute(
      "/${AppRoutes.login}",
      transition: TransitionType.fadeIn,
      child: (context, args) => const AuthScreen(),
    ),
    ModuleRoute(AppRoutes.dashboardModule, module: DashboardModule()),
  ];
}

class AnimalApp extends StatelessWidget {
  const AnimalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
