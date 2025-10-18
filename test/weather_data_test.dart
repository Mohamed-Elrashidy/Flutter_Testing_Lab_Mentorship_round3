import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/weather_display.dart';

void main() {
  test("celsius to fahrenheit", () async {
    expect(celsiusToFahrenheit(100.0), 212.0);
    expect(celsiusToFahrenheit(-40.0), -40.0);
  });

  test("fahrenheit to celsius", () async {
    expect(fahrenheitToCelsius(32), 0);
    expect(fahrenheitToCelsius(212), 100);
    expect(fahrenheitToCelsius(-40), -40);
  });

  testWidgets("widget displays loading indicator initially", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: WeatherDisplay())),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets("widget displays weather data after loading", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: WeatherDisplay())),
    );

    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets("city dropdown shows all available cities", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: WeatherDisplay())),
    );

    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();

    expect(find.text('New York'), findsWidgets);
    expect(find.text('London'), findsOneWidget);
    expect(find.text('Tokyo'), findsOneWidget);
    expect(find.text('Invalid City'), findsOneWidget);
  });

  testWidgets("changing city triggers new data load", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: WeatherDisplay())),
    );

    await tester.pumpAndSettle(const Duration(seconds: 3));

    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('London').last);
    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('London'), findsWidgets);
  });

  testWidgets("temperature unit toggle switches between C and F", (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: WeatherDisplay())),
    );

    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('Celsius'), findsOneWidget);
    expect(find.textContaining('°C'), findsOneWidget);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(find.text('Fahrenheit'), findsOneWidget);
    expect(find.textContaining('°F'), findsOneWidget);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(find.text('Celsius'), findsOneWidget);
  });

  testWidgets("refresh button reloads weather data", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: WeatherDisplay())),
    );

    await tester.pumpAndSettle(const Duration(seconds: 3));

    await tester.tap(find.text('Refresh'));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.byType(Card), findsOneWidget);
  });

  testWidgets("displays city name correctly", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: WeatherDisplay())),
    );

    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('New York'), findsWidgets);
  });

  testWidgets("displays weather icon", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: WeatherDisplay())),
    );

    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('☀️'), findsOneWidget);
  });

  testWidgets("displays weather description", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: WeatherDisplay())),
    );

    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('Sunny'), findsOneWidget);
  });

  testWidgets("displays humidity information", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: WeatherDisplay())),
    );

    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('Humidity'), findsOneWidget);
    expect(find.textContaining('%'), findsOneWidget);
  });

  testWidgets("displays wind speed information", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: WeatherDisplay())),
    );

    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('Wind Speed'), findsOneWidget);
    expect(find.textContaining('km/h'), findsOneWidget);
  });

  testWidgets("displays humidity icon", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: WeatherDisplay())),
    );

    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.byIcon(Icons.water_drop), findsOneWidget);
  });

  testWidgets("displays wind speed icon", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: WeatherDisplay())),
    );

    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.byIcon(Icons.air), findsOneWidget);
  });

  testWidgets("temperature conversion displays correct fahrenheit value", (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: WeatherDisplay())),
    );

    await tester.pumpAndSettle(const Duration(seconds: 3));

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(find.textContaining('72.5°F'), findsOneWidget);
  });

  testWidgets("different cities show different weather data", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: WeatherDisplay())),
    );

    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.text('Sunny'), findsOneWidget);

    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('London').last);
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('Rainy'), findsOneWidget);
    expect(find.text('🌧️'), findsOneWidget);
  });

  testWidgets("switch maintains state during city change", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: WeatherDisplay())),
    );

    await tester.pumpAndSettle(const Duration(seconds: 3));

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(find.text('Fahrenheit'), findsOneWidget);

    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tokyo').last);
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('Fahrenheit'), findsOneWidget);
    expect(find.textContaining('°F'), findsOneWidget);
  });
}
