part of 'page_view_controller_notifier.dart';

class PageViewControllerState extends Equatable {
  final int page;
  final int pageCount;

  const PageViewControllerState({this.page = 0, required this.pageCount});

  PageViewControllerState copyWith({
    int? page,
    int? pageCount,
  }) {
    return PageViewControllerState(
      page: page ?? this.page,
      pageCount: pageCount ?? this.pageCount,
    );
  }

  @override
  List<Object> get props => [page, pageCount];
}
