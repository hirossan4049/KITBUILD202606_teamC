import 'package:day1_flutter_basics/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows sample text', (tester) async {
    await tester.pumpWidget(const EventPairApp());

    expect(find.text('サンプル'), findsOneWidget);
  });
}
