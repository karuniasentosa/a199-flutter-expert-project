import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/presentation/widgets/season_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Wrapping [SeasonCard] inside [MaterialApp]
/// otherwise it shows 'No [Directionality] widget found' error.
Widget createSeasonCard(Season season) =>
    MaterialApp(home: SeasonCard(season));

void main() {
  testWidgets('should show season name and number(with one digit) on the card', (WidgetTester tester) async {
    final tSeason = Season(
        id: 1,
        posterPath: '/a.jpg',
        name: 'Winter has come',
        overview: 'Asdfghjkl',
        seasonNumber: 2
    );
    await tester.pumpWidget(createSeasonCard(tSeason));

    expect(find.text('Winter has come'), findsOneWidget);
    expect(find.text('02'), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });

  testWidgets('should show season name and number(more than one digit) on the card', (WidgetTester tester) async {
    final tSeason = Season(
        id: 1,
        posterPath: '/a.jpg',
        name: 'Winter has come',
        overview: 'Asdfghjkl',
        seasonNumber: 23
    );
    await tester.pumpWidget(createSeasonCard(tSeason));

    expect(find.text('Winter has come'), findsOneWidget);
    expect(find.text('23'), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });
}