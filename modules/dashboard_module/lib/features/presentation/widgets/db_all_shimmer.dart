import 'package:flutter/material.dart';
import 'package:share_module/core/constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class FeedShimmerWidget extends StatelessWidget {
  const FeedShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2.2,
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.surface),
          child: Shimmer.fromColors(
            baseColor: AppColors.border,
            highlightColor: AppColors.surface,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColors.background),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 14,
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppColors.background),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 14,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppColors.background),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                      Container(
                        height: 20,
                        width: 4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.background),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.background),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        height: 16,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.background),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(width: 8),
                            Container(
                              height: 36,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: AppColors.background),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 2.2,
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.surface),
          child: Shimmer.fromColors(
            baseColor: AppColors.border,
            highlightColor: AppColors.surface,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColors.background),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 14,
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppColors.background),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 14,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppColors.background),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                      Container(
                        height: 20,
                        width: 4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.background),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.background),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        height: 16,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.background),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(width: 8),
                            Container(
                              height: 36,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: AppColors.background),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
