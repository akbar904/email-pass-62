
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/screens/home_screen.dart';
import 'package:com.example.flutter_cubit_app/cubits/home_cubit.dart';
import 'package:com.example.flutter_cubit_app/cubits/home_state.dart';

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		testWidgets('displays the logout button', (WidgetTester tester) async {
			// Arrange
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: HomeScreen(),
					),
				),
			);
			
			// Act & Assert
			expect(find.byType(LogoutButton), findsOneWidget);
		});
	});

	group('HomeCubit Unit Tests', () {
		blocTest<MockHomeCubit, HomeState>(
			'emits LoggedOut when logout is called',
			build: () => MockHomeCubit(),
			act: (cubit) => cubit.logout(),
			expect: () => [isA<LoggedOut>()],
		);
	});
}
