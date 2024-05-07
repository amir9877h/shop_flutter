import 'package:flutter/material.dart';
import 'package:shop_flutter/common/utils.dart';
import 'package:shop_flutter/data/banner.dart';
import 'package:shop_flutter/ui/widgets/image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  final PageController pageController = PageController();
  final List<BannerEntity> banners;
  BannerSlider({
    super.key,
    required this.banners,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Stack(
        children: [
          PageView.builder(
              physics: defaultscrollphysics,
              controller: pageController,
              itemCount: banners.length,
              itemBuilder: ((context, index) {
                return _Slide(
                  bannerEntity: banners[index],
                );
              })),
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: banners.length,
                axisDirection: Axis.horizontal,
                effect: WormEffect(
                    spacing: 4.0,
                    radius: 4.0,
                    dotWidth: 24.0,
                    dotHeight: 3.0,
                    paintStyle: PaintingStyle.fill,
                    // strokeWidth: 1.5,
                    dotColor: Colors.grey.shade400,
                    activeDotColor: Theme.of(context).colorScheme.onBackground),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final BannerEntity bannerEntity;

  const _Slide({
    super.key,
    required this.bannerEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: ImageLoadingService(
        borderRadius: BorderRadius.circular(12),
        imageUrl: bannerEntity.imageUrl,
      ),
    );
  }
}
