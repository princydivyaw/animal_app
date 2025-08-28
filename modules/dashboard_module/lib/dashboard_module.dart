import 'package:dashboard_module/config/db_routes.dart';
import 'package:dashboard_module/features/data/datasources/db_datasources.dart';
import 'package:dashboard_module/features/data/repositories/db_repository_impl.dart';
import 'package:dashboard_module/features/domain/repositories/db_repositories.dart';
import 'package:dashboard_module/features/domain/usecases/db_usecases.dart';
import 'package:dashboard_module/features/presentation/cubit/db_cubit.dart';
import 'package:dashboard_module/features/presentation/cubit/db_sell_confirm_cubit.dart';
import 'package:dashboard_module/features/presentation/pages/dashboard_screen.dart';
import 'package:dashboard_module/features/presentation/pages/failure_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'features/presentation/pages/db_sell_confirm_screen.dart';

class DashboardModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton<DbDataSource>((i) => DbDataSourceImpl()),
    Bind.singleton<DbRepository>(
      (i) => DbRepositoryImpl(dbDataSource: i<DbDataSource>()),
    ),
    Bind.singleton<DbUseCase>(
      (i) => DbUseCase(dbRepository: i<DbRepository>()),
    ),
    Bind.singleton<DBCubit>(
      (i) => DBCubit(i<DbUseCase>()),
    ),
    Bind.singleton<DbSellConfirmCubit>(
      (i) => DbSellConfirmCubit(i<DbUseCase>()),
    ),
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          DbRoutes.dashboardScreen,
          transition: TransitionType.fadeIn,
          child: (context, args) => const DashboardScreen(),
        ),
        ChildRoute(
          "/${DbRoutes.failure}",
          transition: TransitionType.fadeIn,
          child: (context, args) => const FailureScreen(),
        ),
        ChildRoute(
          "/${DbRoutes.sellConfirm}",
          transition: TransitionType.fadeIn,
          child: (context, args) {
            final files =
                (args.data as Map)['files'] as List<PlatformFile>? ?? [];
            return const DbSellConfirmScreen(/*files: files*/);
          },
        ),
      ];
}
