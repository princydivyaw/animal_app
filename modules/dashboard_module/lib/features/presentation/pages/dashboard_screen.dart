import 'package:dashboard_module/config/db_strings.dart';
import 'package:dashboard_module/features/presentation/pages/db_home_screen.dart';
import 'package:dashboard_module/features/presentation/pages/db_sell_screen.dart';
import 'package:dashboard_module/features/presentation/pages/failure_screen.dart';
import 'package:dashboard_module/features/presentation/widgets/db_common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:share_module/core/constants/app_assets.dart';
import 'package:share_module/core/constants/app_colors.dart';
import 'package:share_module/core/theme/text_styles.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool notFound = false;
  int pageIndex = 0;

  void selectPageItem(int index) {
    setState(() {
      pageIndex = index;
      notFound = pageIndex != 0 && pageIndex != 1;
    });

    switch (pageIndex) {
      case 1:
        getSell();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.teal,
            title: Text(
              DbStrings.dbAppBarTxt,
              style: AppTextStyles.bodyBold(color: AppColors.textOnPrimary),
            ),
          ),
          body: notFound
              ? const FailureScreen()
              : /*pageIndex == 1
                  ? const showMoreOption()
                  : */
              const DbHomeScreen(),
          bottomNavigationBar: bottomBarItems(context),
        ),
      ),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return notFound
        ? DBCommonAppbar(
            backgroundColor: AppColors.surface,
            title: Image.asset(
              "assets/images/animall_logo_white.png",
              color: AppColors.primary,
              height: 30,
            ),
            elevation: 2,
            isLeading: false,
          )
        : DBCommonAppbar(
            backgroundColor: AppColors.primary,
            title: Image.asset(
              "assets/images/animall_logo_white.png",
              height: 30,
            ),
            isLeading: false,
            opacityColor: Colors.white,
            elevation: 10,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: Colors.teal,
                        size: 14,
                      ),
                      Text(
                        " 0/10",
                        style:
                            AppTextStyles.captionBold(color: AppColors.primary),
                      )
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundImage: AssetImage(
                    AppAssets.appDefaultProfileAvatar,
                  ),
                ),
              )
            ],
          );
  }

  Widget bottomBarItems(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.surface,
      currentIndex: pageIndex,
      selectedItemColor: notFound ? AppColors.border : AppColors.primary,
      unselectedItemColor: AppColors.border,
      onTap: selectPageItem,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: DbStrings.dbHomeItemTxt,
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.sell_rounded),
          label: DbStrings.dbSellingItemTxt,
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.add_shopping_cart),
          label: DbStrings.dbBuyingItemTxt,
        ),
        notFound
            ? const BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: DbStrings.dbAccountItemTxt,
              )
            : BottomNavigationBarItem(
                icon: Container(
                    decoration: const BoxDecoration(color: AppColors.border),
                    child: const Icon(
                      Icons.toc_outlined,
                      color: AppColors.surface,
                    )),
                label: DbStrings.dbAccountItemTxt,
              ),
      ],
    );
  }

  Future<dynamic> showMoreOption() {
    final List<Map<String, dynamic>> item = [
      {"user": "Why you're seeing this post", "icon": Icons.info_outline},
      {"user": "Hide", "icon": Icons.visibility_off_rounded},
      {"user": "About this account", "icon": Icons.account_circle_outlined},
      {"user": "Report", "icon": Icons.perm_device_info_rounded},
    ];

    return showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return InkWell(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // makes it wrap content
              children: [
                Container(
                  height: 2,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.016,
                ),
                if (item.isNotEmpty)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: item.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(item[index]["icon"] as IconData,
                                  color: AppColors.backgroundDark),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.016,
                              ),
                              Text(
                                item[index]["user"],
                                style: AppTextStyles.bodyNormal(
                                    color: AppColors.textPrimary),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> getSell() async {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const DbSellScreen(),
    );

    if (result == null) {
      print("User posted: $result");
      setState(() {
        pageIndex = 0;
      });
    }
  }
}
