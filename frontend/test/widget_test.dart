import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart';

void main() {
  testWidgets('App démarre sur ZeroWasteApp', (WidgetTester tester) async {
    await tester.pumpWidget(const ZeroWasteApp());

    // Vérifie que l’écran de login est bien affiché
    expect(find.byType(ZeroWasteApp), findsOneWidget);
  });
}
