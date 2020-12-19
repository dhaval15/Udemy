import 'package:flutter_test/flutter_test.dart';
import 'package:news/src/resources/respository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Reposiory.fetchIds', () async {
    final repository = Repository();
    final ids = await repository.fetchIds();
    expect(ids[0].runtimeType, int);
  });
}
