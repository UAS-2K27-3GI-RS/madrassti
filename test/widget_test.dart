import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:madrassti/app.dart';

void main() {
  testWidgets('Welcome screen shows Madrassti and roles', (tester) async {
    await initializeDateFormatting('fr');
    await tester.pumpWidget(const MadrasstiApp());
    await tester.pumpAndSettle();

    expect(find.text('Madrassti'), findsOneWidget);
    expect(find.text('Parent'), findsOneWidget);
    expect(find.text('Élève'), findsOneWidget);
    expect(find.text('Enseignant'), findsOneWidget);
  });
}
