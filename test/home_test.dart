import 'package:crypto_demo/Model/coin_model.dart';
import 'package:crypto_demo/View/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Home Widget Tests', () {
    final mockData = [
      CoinModel(
          id: "bitcoin",
          symbol: "btc",
          name: "Bitcoin",
          currentPrice: 45000.0,
          image: "",
          marketCapRank: 1,
          totalVolume: 350000000,
          high24H: 46000.0,
          low24H: 44000.0,
          priceChange24H: -500.0,
          marketCapChangePercentage24H: 0.0,
          sparklineIn7D: SparklineIn7D(price: [
            45000.0,
            46000.0,
            45500.0,
            44000.0,
            44500.0,
            44500.0,
            45000.0
          ])),
      CoinModel(
          id: "ethereum",
          symbol: "eth",
          name: "Ethereum",
          currentPrice: 3200.0,
          image: "",
          marketCapRank: 2,
          totalVolume: 180000000,
          high24H: 3300.0,
          low24H: 3100.0,
          priceChange24H: -100.0,
          marketCapChangePercentage24H: 0.0,
          sparklineIn7D: SparklineIn7D(price: [
            45000.0,
            46000.0,
            45500.0,
            44000.0,
            44500.0,
            44500.0,
            45000.0
          ])),
    ];

    testWidgets('Displays loading indicator initially',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Home()));

      // Expect the loading indicator to appear
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for any async tasks or state changes to complete
      await tester.pumpAndSettle();

      // Additional check can be added if needed, such as checking if the loading indicator is removed
      expect(find.byType(CircularProgressIndicator),
          findsNothing); // If the loading is done
    });

    testWidgets('Shows error message when there is no data',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Home(mockData: [])));

      await tester.pumpAndSettle(); // Wait for the widget to update

      expect(find.text("No data available"), findsOneWidget);
    });

    testWidgets('Displays list of coins when data is available',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Home(mockData: mockData)));

      // Wait for the widget to settle
      await tester.pumpAndSettle();

      // Expect both Bitcoin and Ethereum to be displayed
      expect(find.text("Bitcoin"), findsOneWidget);
      expect(find.text("Ethereum"), findsOneWidget);

      // You can further check for other elements, such as price or symbol
      expect(find.text("\$45000.0"), findsOneWidget); // Example check
    });
  });
}
