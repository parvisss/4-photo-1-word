import 'package:find_the_word_from_pics/ui/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    "filled button",
    (tester) async {
      await tester.pumpWidget(const MaterialApp(home: MainScreen()));
      expect(find.byType(FilledButton), findsOneWidget);
      expect(find.byKey(const ValueKey("Check Word")), findsOneWidget);
    },
  );
  testWidgets(
    "IMages",
    (tester) async {
      await tester.pumpWidget(const MaterialApp(home: MainScreen()));
      expect(find.byKey(const ValueKey("image")), findsNWidgets(4));
    },
  );
  testWidgets(
    "button",
    (tester) async {
      await tester.pumpWidget(const MaterialApp(home: MainScreen()));
      expect(find.byKey(const ValueKey("dlete")), findsOneWidget);
    },
  );
  testWidgets(
    "letters",
    (tester) async {
      await tester.pumpWidget(const MaterialApp(home: MainScreen()));
      expect(find.byKey(const ValueKey("letters")), findsAny);
    },
  );
}
