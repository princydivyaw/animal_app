import 'package:dashboard_module/config/db_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:share_module/core/constants/app_assets.dart';
import 'package:share_module/core/constants/app_colors.dart';
import 'package:share_module/core/theme/text_styles.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({
    super.key,
  });

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  List item = [
    AppAssets.dbThreeBanner,
    AppAssets.dbTwoBanner,
    AppAssets.dbOneBanner
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.surface,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: item.length,
                  itemBuilder: (context, int i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Image.asset(item[i], height: 120),
                    );
                  }),
              const SizedBox(height: 48),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 36,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 0.9,
                    children: [
                      DashboardCard(
                        icon: Icons.add_shopping_cart,
                        count: "24",
                        label: "Buy",
                        pageScreen: "/dashboardModule/${DbRoutes.dbMainScreen}",
                      ),
                      DashboardCard(
                        icon: Icons.sell_outlined,
                        count: "12",
                        label: "Sell",
                        pageScreen: "/dashboardModule/${DbRoutes.dbMainScreen}",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatefulWidget {
  final IconData icon;
  final String count;
  final String label;
  final String pageScreen;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.count,
    required this.label,
    required this.pageScreen,
  });

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard>
    with SingleTickerProviderStateMixin {
  late AnimationController cardController;

  @override
  void initState() {
    super.initState();
    cardController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    cardController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Modular.to.pushNamed(widget.pageScreen);
      }
    });
  }

  void triggerAnimation() {
    cardController.forward(from: 0.0); // restart animation
  }

  @override
  void dispose() {
    cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          // border: Border.all(color: AppColors.backgroundDark),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBlack.withValues(alpha: 0.25),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(2, 3),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                  foregroundColor: AppColors.primary,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child:
                        Icon(widget.icon, size: 40, color: AppColors.primary),
                  )),
              Text(
                widget.count,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // const Divider(
          //   color: AppColors.backgroundDark,
          // ),
          GestureDetector(
            onTap: triggerAnimation,
            child: AnimatedBuilder(
                animation: cardController,
                builder: (context, child) {
                  double value = cardController.value;
                  return Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: const [
                            AppColors.primary,
                            AppColors.surface,
                          ],
                          stops: [value, value],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryDark.withValues(alpha: 0.2),
                            blurRadius: 2,
                            offset: Offset(2, 0.5),
                          ),
                        ],
                      ),
                      child: Stack(children: [
                        FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: value,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 16.0),
                          child: Text(
                            widget.label,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodyNormal(
                              color: value == 1.0
                                  ? AppColors.textOnPrimary
                                  : AppColors.primary,
                            ),
                          ),
                        ),
                      ]));
                }),
          )
        ],
      ),
    );
  }
}
