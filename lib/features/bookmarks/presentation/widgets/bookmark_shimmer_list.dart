// features/bookmarks/presentation/widgets/bookmark_shimmer_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/constants/app_colors.dart';

class BookmarkShimmerList extends StatelessWidget {
  const BookmarkShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Shimmer.fromColors(
      baseColor: colors.surface.withValues(alpha: 0.4),
      highlightColor: colors.background.withValues(alpha: 0.2),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 2,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200.h,
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(14.r),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 80.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: colors.surface,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        width: double.infinity,
                        height: 16.h,
                        color: colors.surface,
                      ),
                      SizedBox(height: 6.h),
                      Container(
                        width: 200.w,
                        height: 16.h,
                        color: colors.surface,
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100.w,
                            height: 12.h,
                            color: colors.surface,
                          ),
                          Container(
                            width: 60.w,
                            height: 12.h,
                            color: colors.surface,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
