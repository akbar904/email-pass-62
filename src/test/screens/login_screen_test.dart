
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.flutter_cubit_app/screens/login_screen.dart';

void main() {
	group('LoginScreen Widget Tests', () {
		testWidgets('should have a title Login', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: LoginScreen()));
			expect(find.text('Login'), findsOneWidget);
		});

		testWidgets('should have email and password TextFormFields', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: LoginScreen()));
			expect(find.byType(TextFormField), findsNWidgets(2));
			expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);
			expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);
		});

		testWidgets('should have a login button', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: LoginScreen()));
			expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
		});
	});

	group('LoginCubit Tests', () {
		// Assuming that the LoginCubit is only used in this screen and is defined in the same file.
		blocTest<LoginCubit, LoginState>(
			'emits [LoginLoading, LoginSuccess] when login is successful',
			build: () => LoginCubit(),
			act: (cubit) => cubit.login('email@example.com', 'password123'),
			expect: () => [LoginLoading(), LoginSuccess()],
		);

		blocTest<LoginCubit, LoginState>(
			'emits [LoginLoading, LoginFailure] when login fails',
			build: () => LoginCubit(),
			act: (cubit) => cubit.login('wrongemail@example.com', 'wrongpassword'),
			expect: () => [LoginLoading(), LoginFailure('Invalid credentials')],
		);
	});
}
