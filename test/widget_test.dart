import 'package:flutter_test/flutter_test.dart';
import 'package:moodleaf/main.dart';

void main() {
  testWidgets('MoodLeafApp launches', (WidgetTester tester) async {
    await tester.pumpWidget(const MoodLeafApp());
    expect(find.byType(MoodLeafApp), findsOneWidget);
  });
}
