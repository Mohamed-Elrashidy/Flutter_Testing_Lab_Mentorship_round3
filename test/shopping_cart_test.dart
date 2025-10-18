import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/shopping_cart.dart';

void main() {
  group('ShoppingCart widget tests', () {
    testWidgets('starts empty and shows empty message', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: ShoppingCart())),
      );

      expect(find.text('Cart is empty'), findsOneWidget);
      expect(find.text('Total Items: 0'), findsOneWidget);
      expect(find.textContaining('Subtotal:'), findsOneWidget);
    });

    testWidgets('addItem increases total items and updates totals', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: ShoppingCart())),
      );

      // Tap Add iPhone button
      await tester.tap(find.text('Add iPhone'));
      await tester.pump();

      // After adding, total items should be 1
      expect(find.textContaining('Total Items: 1'), findsOneWidget);
      expect(find.text('Cart is empty'), findsNothing);

      // Subtotal should reflect price 999.99
      expect(find.textContaining('Subtotal: \$999.99'), findsOneWidget);
    });

    testWidgets('adding same item again increases quantity', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: ShoppingCart())),
      );

      await tester.tap(find.text('Add iPhone'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add iPhone Again'));
      await tester.pumpAndSettle();

      // Total items should be 2
      expect(find.textContaining('Total Items: 2'), findsOneWidget);
      // Quantity display should show 2
      expect(find.text('2'), findsWidgets);
    });

    testWidgets('removeItem decreases quantity and removes when zero', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: ShoppingCart())),
      );

      await tester.tap(find.text('Add iPad'));
      await tester.pump();

      // Increase quantity to 2 using add button on list tile
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Now decrease using remove button
      await tester.tap(find.byIcon(Icons.remove).first);
      await tester.pump();

      // Quantity should be 1
      expect(find.text('1'), findsWidgets);

      // Remove using removeItem (delete) twice to remove from cart
      await tester.tap(find.byIcon(Icons.remove).first);
      await tester.pump();

      // Cart should be empty again
      expect(find.text('Cart is empty'), findsOneWidget);
    });

    testWidgets('100% discount results in zero total for that item', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: ShoppingCart())),
      );
      var appleIphone = find.widgetWithText(ElevatedButton, 'Add iPhone');
      await tester.tap(appleIphone);
      await tester.pumpAndSettle();
      var totalAmountFinder = find.textContaining('Total Amount: \$0.00');
      expect(totalAmountFinder, findsOneWidget);
    });

    testWidgets(
      'quantity limits: check if update quantity will break max quantity',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: ShoppingCart())),
        );

        var appleIphoneQuantity = find.widgetWithText(
          ElevatedButton,
          'Add iPhone',
        );
        await tester.tap(appleIphoneQuantity);
        await tester.pumpAndSettle();
        await tester.tap(appleIphoneQuantity);
        await tester.pumpAndSettle();
        await tester.tap(appleIphoneQuantity);
        await tester.pumpAndSettle();
        await tester.tap(appleIphoneQuantity);
        await tester.pumpAndSettle();

        expect(find.textContaining('Total Items: 3'), findsOneWidget);
      },
    );

    testWidgets('clearCart empties the cart', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: ShoppingCart())),
      );

      await tester.tap(find.text('Add iPad'));
      await tester.pumpAndSettle();
      var totalItemsFinder = find.textContaining('Total Items: 1');
      expect(totalItemsFinder, findsOneWidget);
      // Clear the cart
      await tester.tap(find.text('Clear Cart'));
      await tester.pumpAndSettle();
      expect(find.text('Cart is empty'), findsOneWidget);
    });
  });
}
