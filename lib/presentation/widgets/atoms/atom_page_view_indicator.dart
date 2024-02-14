import 'package:animate_do/animate_do.dart';
import 'package:flutter/widgets.dart';
import 'package:tradex_wallet_3/config/theme/custom_colors.dart';

class AtomPageViewIndicator extends StatelessWidget {
  final int pageCount;
  final int currentPage;
  final Color activeColor;
  final Color inactiveColor;
  final double dotSize;
  final double width;
  final double indicatorHeight;

  const AtomPageViewIndicator({
    super.key,
    required this.pageCount,
    required this.currentPage,
    this.activeColor = CustomColors.accent,
    this.inactiveColor = CustomColors.primary,
    this.dotSize = 8.0,
    this.width = 100.0,
    this.indicatorHeight = 2.0,
  });

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      height: isActive ? dotSize * 1.2 : dotSize,
      width: isActive ? dotSize * 1.2 : dotSize,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inactiveColor,
        shape: BoxShape.circle,
      ),
      duration: const Duration(milliseconds: 500),
    );
  }

  Widget _buildLine(bool isActive) {
    return AnimatedContainer(
      height: isActive ? indicatorHeight * 1.4 : indicatorHeight,
      color: isActive ? activeColor : inactiveColor,
      duration: const Duration(milliseconds: 300),
    );
  }

  List<Widget> _buildIndicators() {
    List<Widget> indicators = [];
    for (int i = 0; i < pageCount; i++) {
      indicators.add(BounceInDown(
        delay: Duration(milliseconds: (i + 1) * 100),
        child: _buildIndicator(i <= currentPage),
      ));
      if (i < pageCount - 1) {
        indicators.add(Expanded(
          child: FadeIn(
            delay: const Duration(milliseconds: 1300),
            child: _buildLine(i <= currentPage - 1),
          ),
        ));
      }
    }
    return indicators;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildIndicators(),
      ),
    );
  }
}
