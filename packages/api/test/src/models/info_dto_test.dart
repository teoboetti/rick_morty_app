import 'package:api/src/models/info_dto.dart';
import 'package:test/test.dart';

void main() {
  test('InfoDto', () {
    const count = 10;
    const pages = 5;

    const infoDto = InfoDto(
      count: count,
      pages: pages,
    );

    expect(infoDto.count, equals(count));
    expect(infoDto.pages, equals(pages));
  });
}
