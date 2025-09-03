import 'package:dashboard_module/features/domain/entities/db_get_comment_entity.dart';
import 'package:dashboard_module/features/domain/entities/db_home_feeds_entity.dart';
import 'package:dashboard_module/features/presentation/cubit/db_cubit.dart';
import 'package:dashboard_module/features/presentation/cubit/db_state.dart';
import 'package:dashboard_module/features/presentation/widgets/db_all_shimmer.dart';
import 'package:dashboard_module/features/presentation/widgets/db_video_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:share_module/core/constants/app_assets.dart';
import 'package:share_module/core/constants/app_colors.dart';
import 'package:share_module/core/theme/text_styles.dart';
import 'package:share_module/core/utils/app_common_utils.dart';

class DbHomeScreen extends StatefulWidget {
  const DbHomeScreen({super.key});

  @override
  State<DbHomeScreen> createState() => DbHomeScreenState();
}

class DbHomeScreenState extends State<DbHomeScreen> {
  final PageController itemController = PageController();
  final ScrollController scrollController = ScrollController();

  int currentItem = 0;

  DbHomeFeedsEntity? feedsEntity;

  final dbCubit = Modular.get<DBCubit>();

  bool isLikeTap = false;

  @override
  void initState() {
    super.initState();
    dbCubit.getFeedData();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (feedsEntity != null &&
            feedsEntity!.data.isNotEmpty &&
            feedsEntity!.data.length > 10) {
          /*  Modular.to
              .popUntil(ModalRoute.withName(AppRoutes.login));*/ //dialoague more explore
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: dbCubit,
        listener: (context, state) {
          if (state is GetFeedDataLoadedState) {
            feedsEntity = state.feedEntity;
          }
          if (state is GetCommentLoadedState) {
            showComments(item: state.entity.data);
          } else if (state is GetCommentErrorState) {}
        },
        builder: (context, state) {
          if (state is GetFeedDataLoadingState) {
            return const FeedShimmerWidget();
          } else {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(),
              padding: const EdgeInsets.only(top: 16.0),
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: feedsEntity!.data.length,
                  itemBuilder: (context, int index) {
                    var item = feedsEntity!.data[index];
                    return Container(
                      // height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      // padding: const EdgeInsets.all(16.0),
                      margin: const EdgeInsets.only(
                          right: 16.0, left: 16.0, bottom: 16.0),
                      decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryBlack
                                  .withValues(alpha: 0.25),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: const Offset(2, 3),
                            ),
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headingWidget(
                            item: item,
                          ),
                          contentWidget(item: item),
                          footerWidget(item: item)
                        ],
                      ),
                    );
                  }),
            );
          }
        });
  }

  Widget headingWidget({required DbHomeFeedsDataEntity item}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.error,
            backgroundImage: AssetImage(
              AppAssets.appDefaultProfileAvatar,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.016,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.ownerDetails.ownerName,
                style: AppTextStyles.captionBold(color: AppColors.textPrimary),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    // color: AppColors.surface,
                    size: 12.0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.002,
                  ),
                  Text(
                    item.ownerDetails.ownerPostStatus,
                    style:
                        AppTextStyles.labelNormal(color: AppColors.textPrimary),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.016,
                  ),
                  const Icon(
                    Icons.location_on_rounded,
                    // color: AppColors.surface,
                    size: 12.0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.002,
                  ),
                  Text(
                    item.ownerDetails.ownerLocation,
                    style:
                        AppTextStyles.labelNormal(color: AppColors.textPrimary),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () async {
              showMoreOption();
            },
            child: const Icon(
              Icons.more_vert_rounded,
              size: 16,
              color: AppColors.backgroundDark,
            ),
          )
        ],
      ),
    );
  }

  Widget footerWidget({required DbHomeFeedsDataEntity item}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    tapLike(tap: "");
                  },
                  child: Icon(
                      isLikeTap
                          ? Icons.favorite_rounded
                          : Icons.favorite_border,
                      color: isLikeTap
                          ? AppColors.error
                          : AppColors.backgroundDark,
                      size: 24)),
              Text(
                "1k",
                style:
                    AppTextStyles.captionNormal(color: AppColors.textPrimary),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.016,
              ),
              GestureDetector(
                  onTap: () {
                    dbCubit.getComments();
                  },
                  child: const Icon(Icons.mode_comment_outlined, size: 24)),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.016,
              ),
              GestureDetector(
                onTap: () {
                  createAndShareFile(
                      url: item.animalDetails.animalCollection.first.itemUrl);
                },
                child: const Icon(
                  Icons.send_outlined,
                  size: 24,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.bookmark_border,
                size: 24,
              ),
            ],
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "${item.animalDetails.animalName} | ${item.animalDetails.animalStatus} | ${item.animalDetails.milkStatus} | ${item.animalDetails.animalRate}",
              style: AppTextStyles.captionBold(color: AppColors.textPrimary),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Divider(
            height: 1,
            color: AppColors.border,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              right: 8.0, left: 8.0, top: 8.0, bottom: 16.0),
          child: Row(
            children: [
              Text(
                "Owner Details",
                style: AppTextStyles.bodyNormal(color: AppColors.textPrimary),
              ),
              const Spacer(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.info,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {},
                icon: const Icon(Icons.call, color: AppColors.background),
                label: const Text("Call",
                    style: TextStyle(color: AppColors.background)),
              ),
              /*  const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {},
                child: const Icon(
                  Icons.message_rounded,
                  color: AppColors.background,
                ),
              ),*/
            ],
          ),
        ),
      ],
    );
  }

  Widget contentWidget({required DbHomeFeedsDataEntity item}) {
    return item.animalDetails.animalCollection.isEmpty
        ? emptyItems()
        : feedItems(item: item.animalDetails.animalCollection);
  }

  Widget emptyItems() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.33,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.032,
          ),
          const Icon(Icons.photo, size: 40, color: Colors.grey),
          Text("The pet owner has not uploaded the photo",
              style:
                  AppTextStyles.captionNormal(color: AppColors.textSecondary)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.016,
          ),
          InkWell(
            onTap: () {
              showLoginDialog();
            },
            child: Text("Ask for a photo",
                style: AppTextStyles.captionBold(color: AppColors.primary)),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.048,
          ),
        ],
      ),
    );
  }

  Widget feedItems({required List<AnimalCollectionEntity> item}) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.33,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            // border: Border.all(color: Colors.red),
          ),
          child: PageView.builder(
            controller: itemController,
            itemCount: item.length,
            onPageChanged: (index) {
              setState(() => currentItem = index);
            },
            itemBuilder: (context, index) {
              final media = item[index];

              if (media.itemType == "image") {
                return InkWell(
                    onDoubleTap: () {
                      tapLike(tap: "double");
                    },
                    child: Image.network(media.itemUrl, fit: BoxFit.cover));
              } else if (media.itemType == "video") {
                return InkWell(
                  onDoubleTap: () {
                    tapLike(tap: "double");
                  },
                  child: VideoPlayerWidget(
                    videoUrl: media.itemUrl,
                  ),
                );
              } else {
                return const Center(child: Text("Unsupported media"));
              }
            },
          ),
        ),

        // Dots Indicator
        if (item.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              item.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                width: currentItem == index ? 10 : 6,
                height: currentItem == index ? 10 : 6,
                decoration: BoxDecoration(
                  color: currentItem == index
                      ? AppColors.primary
                      : AppColors.border,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    itemController.dispose();
    super.dispose();
  }

  ///functionality

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
          child: Column(
            mainAxisSize: MainAxisSize.min, // makes it wrap content
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.016,
              ),
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
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: item.length,
                    itemBuilder: (context, index) {
                      return Container(
                        // decoration: BoxDecoration(
                        //   border: Border.all(
                        //     color: AppColors.error,
                        //   ),
                        // ),
                        padding: const EdgeInsets.only(top: 24.0, left: 16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(item[index]["icon"] as IconData,
                                color: AppColors.backgroundDark),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.016,
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
        );
      },
    );
  }

  Future<dynamic> showLoginDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.lock, size: 48, color: AppColors.primary),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.016),
                  Text("Login to Explore More",
                      style: AppTextStyles.subHeadingSubTitleBold(
                          color: AppColors.primary)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.008),
                  Text("You need to login to access exclusive features.",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.captionNormal(
                          color: AppColors.textPrimary)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.016),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text("Later",
                            style: AppTextStyles.captionNormal(
                                color: AppColors.primary)),
                        onPressed: () => Modular.to.pop(context),
                      ),
                      ElevatedButton(
                        child: Text("Login",
                            style: AppTextStyles.captionBold(
                                color: AppColors.primary)),
                        onPressed: () {
                          Modular.to.pop(context);
                          Modular.to.pushNamed("/login"); // go to login page
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  tapLike({required String tap}) {
    if (tap == "double") {
      setState(() {
        isLikeTap = true;
      });
    } else {
      setState(() {
        isLikeTap = !isLikeTap;
      });
    }
  }

  Future showComments({required List<DbGetCommentDataEntity> item}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: AppColors.background,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  height: 2,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Text("Comments",
                    style:
                        AppTextStyles.bodyNormal(color: AppColors.textPrimary)),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.016,
                ),

                ///list of comment
                Expanded(
                  child: ListView.builder(
                    itemCount: item.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(1),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primary,
                                AppColors.primaryShade
                              ],
                            ),
                          ),
                          child: item[index].commentDetails.cImageUrl.isNotEmpty
                              ? CircleAvatar(
                                  backgroundColor: AppColors.background,
                                  backgroundImage: AssetImage(
                                      item[index].commentDetails.cImageUrl),
                                )
                              : CircleAvatar(
                                  backgroundColor: AppColors.background,
                                  child: Text(
                                    item[index]
                                        .commentDetails
                                        .cName[0]
                                        .toUpperCase(),
                                    style: AppTextStyles.bodyNormal(
                                        color: AppColors.textPrimary),
                                  ),
                                ),
                        ),
                        title: Row(
                          children: [
                            Text(
                              item[index].commentDetails.cName,
                              style: AppTextStyles.bodyNormal(
                                  color: AppColors.textPrimary),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.016,
                            ),
                            Text(
                              item[index].commentDetails.cPostStatus,
                              style: AppTextStyles.captionNormal(
                                  color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          item[index].commentDetails.cComments,
                          style: AppTextStyles.captionNormal(
                              color: AppColors.textPrimary),
                        ),
                      );
                    },
                  ),
                ),

                ///add comment
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: const BoxDecoration(color: AppColors.surface),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage(
                          AppAssets.appDefaultProfileAvatar,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.016,
                      ),
                      Expanded(
                        child: TextField(
                          style: AppTextStyles.bodyNormal(
                              color: AppColors.textPrimary),
                          decoration: InputDecoration(
                            hintText: "Add a comment...",
                            hintStyle: AppTextStyles.bodyNormal(
                                color: AppColors.textSecondary),
                            border: InputBorder.none,
                          ),
                        ),
                      ),

                      ///send feed
                      InkWell(
                          onTap: () {},
                          child:
                              const Icon(Icons.send, color: AppColors.primary)),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> createAndShareFile({required String url}) async {
    AppCommonUtils().downloadAndShare(url);
  }
}
