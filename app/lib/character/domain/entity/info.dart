import 'package:api/api.dart';

class Info {
  Info({
    required this.count,
    required this.pages,
  });

  /// The length of the response
  final int count;

  /// The amount of pages
  final int pages;
}

extension InfoDtoX on InfoDto {
  Info toDomain() {
    return Info(
      count: count,
      pages: pages,
    );
  }
}
