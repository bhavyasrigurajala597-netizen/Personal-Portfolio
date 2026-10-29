import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart' show Size;

import 'package:campus_connect/main.dart';

void main() {
  testWidgets(
      'home shows portfolio content and hides editing/navigation controls',
      (tester) async {
    await tester.pumpWidget(const CampusConnectApp());
    await tester.pumpAndSettle();

    expect(find.text('Bhavya Sri Gurajala'), findsWidgets);
    expect(find.text('Explore My Portfolio'), findsOneWidget);
    expect(find.text('Let\'s Connect'), findsOneWidget);
    expect(find.text('A Little About Me'), findsNothing);
    expect(find.text('What I Work With'), findsNothing);
    expect(find.text('Featured Projects'), findsNothing);
    expect(find.text('Edit Personal Info'), findsNothing);
    expect(find.text('Visit my GitHub'), findsNothing);
    expect(find.text('1 / 6'), findsNothing);
    expect(find.text('Back'), findsNothing);
    expect(find.text('Next'), findsNothing);
  });

  testWidgets('home remains usable at mobile width', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const CampusConnectApp());
    await tester.pumpAndSettle();

    expect(find.text('Hello, Bhavya Sri Gurajala!'), findsOneWidget);
    expect(
        find.text(
            'Get a paid software development internship and build useful real-world projects.'),
        findsOneWidget);
    expect(find.text('Academic Year'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('About is personal-only and Projects has its own editor',
      (tester) async {
    await tester.pumpWidget(const CampusConnectApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('About Me').first);
    await tester.pumpAndSettle();

    expect(find.text('Bhavya Sri Gurajala'), findsWidgets);
    expect(find.text('AI Travel Planner'), findsNothing);
    expect(find.text('Mahaveer School'), findsNothing);
    expect(find.text('Email address'), findsNothing);

    await tester.tap(find.text('Edit Personal Information'));
    await tester.pumpAndSettle();
    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('Email address'), findsNothing);
    expect(find.text('GitHub Repository URL (optional)'), findsNothing);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Projects').first);
    await tester.pumpAndSettle();
    expect(find.text('AI Travel Planner'), findsOneWidget);
    expect(find.text('AI Expense Tracker'), findsOneWidget);
    await tester.tap(find.text('Manage Projects'));
    await tester.pumpAndSettle();
    expect(find.text('Add Project'), findsOneWidget);
    expect(find.text('Project Name'), findsOneWidget);
    expect(find.text('Project Description'), findsNothing);
    expect(find.text('Live-demo URL'), findsNothing);
  });
}
