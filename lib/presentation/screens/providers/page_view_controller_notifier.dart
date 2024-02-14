import 'package:flutter/widgets.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'page_view_controller_state.dart';

class PageViewControllerNotifier
    extends StateNotifier<PageViewControllerState> {
  PageViewControllerNotifier(int pageCount)
      : super(PageViewControllerState(pageCount: pageCount));

  final PageController pageController = PageController();

  num get currentPage => pageController.initialPage;

  void goTo(int toPage) {
    if (toPage == state.page) return;
    if (toPage >= state.pageCount || toPage < 0) return;

    state = state.copyWith(page: toPage);
    pageController.animateToPage(
      toPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void nextPage() {
    final int toPage = (state.page) + 1;
    goTo(toPage);
  }

  void prevPage() {
    final int toPage = (state.page) - 1;
    goTo(toPage);
  }
}
