import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shop_app/app/electronics_shop_app.dart';

void main() {
  testWidgets('app opens home page', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: ElectronicsShopApp(),
      ),
    );

    expect(find.text('Магазин электроники'), findsOneWidget);
    expect(find.text('TechStore'), findsOneWidget);
  });
}
