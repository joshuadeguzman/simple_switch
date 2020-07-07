// Copyright 2020 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:simple_switch/simple_switch.dart';
import '../lib/main.dart';

void main() {
  group('MyHomePage', () {
    testWidgets('initial value of the SimpleSwitch should be set to false',
        (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      final valueToggled = find.text("Value: false");

      expect(valueToggled, findsOneWidget);
    });

    testWidgets('user has toggled the SimpleSwitch to true',
        (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      await tester.tap(find.byType(SimpleSwitch));

      await tester.pump(Duration(milliseconds: 200));

      final valueToggled = find.text("Value: true");

      expect(valueToggled, findsOneWidget);
    });

    testWidgets('user has toggled the SimpleSwitch to false',
        (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      await tester.tap(find.byType(SimpleSwitch));

      await tester.pump(Duration(milliseconds: 200));

      await tester.tap(find.byType(SimpleSwitch));

      await tester.pump(Duration(milliseconds: 200));

      final valueToggled = find.text("Value: false");

      expect(valueToggled, findsOneWidget);
    });
  });
}
