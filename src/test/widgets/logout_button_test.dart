
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/widgets/logout_button.dart';

// Mocking HomeCubit
class MockHomeCubit extends MockCubit<void> implements HomeCubit {}

void main() {
	group('LogoutButton Widget Tests', () {
		late MockHomeCubit mockHomeCubit;

		setUp(() {
			mockHomeCubit = MockHomeCubit();
		});

		testWidgets('should display the logout button with correct text', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<HomeCubit>(
							create: (_) => mockHomeCubit,
							child: LogoutButton(),
						),
					),
				),
			);

			expect(find.byType(ElevatedButton), findsOneWidget);
			expect(find.text('Logout'), findsOneWidget);
		});

		testWidgets('should call logout on HomeCubit when button is pressed', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<HomeCubit>(
							create: (_) => mockHomeCubit,
							child: LogoutButton(),
						),
					),
				),
			);

			await tester.tap(find.byType(ElevatedButton));
			await tester.pump();

			verify(() => mockHomeCubit.logout()).called(1);
		});
	});
}
