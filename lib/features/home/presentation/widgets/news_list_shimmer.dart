// features/home/presentation/widgets/news_list_shimmer.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'news_card_shimmer.dart';

class NewsListShimmer extends StatelessWidget {
  const NewsListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: 16.h),
      itemBuilder: (context, index) {
        return const NewsCardShimmer();
      },
    );
  }
}
