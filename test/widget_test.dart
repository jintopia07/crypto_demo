// ignore_for_file: prefer_const_constructors

import 'package:crypto_demo/View/splash.dart';
import 'package:crypto_demo/View/navBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Splash screen should display logo, text, and button',
      (WidgetTester tester) async {
    // Arrange: Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: Splash(),
      ),
    );

    // Act & Assert
    expect(find.byType(Image), findsOneWidget); // ตรวจสอบว่ามีรูปภาพโลโก้
    expect(find.text('The Future'),
        findsOneWidget); // ตรวจสอบว่ามีข้อความ "The Future"
    expect(find.textContaining('Learn more about cryptocurrency'),
        findsOneWidget); // ตรวจสอบข้อความรายละเอียด
    expect(find.text('CREATE PORTFOLITO'), findsOneWidget); // ตรวจสอบปุ่ม
  });

  testWidgets('Tapping the button should navigate to NavBar screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Splash()));

    // Scroll ให้วิชเจ็ตอยู่ในหน้าจอ
    await tester.ensureVisible(find.text('CREATE PORTFOLITO'));

    // กดปุ่ม
    await tester.tap(find.text('CREATE PORTFOLITO'));
    await tester.pumpAndSettle();

    // ตรวจสอบว่าหน้าจอ NavBar ปรากฏขึ้น
    expect(find.byType(NavBar), findsOneWidget);
  });
}
