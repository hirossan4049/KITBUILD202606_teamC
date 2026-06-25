import 'package:day1_flutter_basics/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows recruitment form', (tester) async {
    await tester.pumpWidget(const EventPairApp());

    expect(find.text('同行募集を作る'), findsOneWidget);
    expect(find.text('サマー音楽フェス 2026'), findsOneWidget);
    expect(find.text('内容を確認する'), findsOneWidget);
  });

  testWidgets('validates required fields', (tester) async {
    await tester.pumpWidget(const EventPairApp());

    await tester.tap(find.text('内容を確認する'));
    await tester.pump();

    expect(find.text('入力してください'), findsNWidgets(2));
  });
}
