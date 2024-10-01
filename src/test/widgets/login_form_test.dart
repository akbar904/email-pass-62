
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/widgets/login_form.dart';

// Mocking the LoginCubit
class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
	group('LoginForm Widget Tests', () {
		late MockLoginCubit mockLoginCubit;

		setUp(() {
			mockLoginCubit = MockLoginCubit();
		});

		testWidgets('renders email and password TextFormFields', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<LoginCubit>(
							create: (_) => mockLoginCubit,
							child: LoginForm(),
						),
					),
				),
			);

			expect(find.byType(TextFormField), findsNWidgets(2));
			expect(find.byKey(Key('emailField')), findsOneWidget);
			expect(find.byKey(Key('passwordField')), findsOneWidget);
		});

		testWidgets('renders login button', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<LoginCubit>(
							create: (_) => mockLoginCubit,
							child: LoginForm(),
						),
					),
				),
			);

			expect(find.byType(ElevatedButton), findsOneWidget);
			expect(find.text('Login'), findsOneWidget);
		});

		testWidgets('calls login on button press', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<LoginCubit>(
							create: (_) => mockLoginCubit,
							child: LoginForm(),
						),
					),
				),
			);

			await tester.enterText(find.byKey(Key('emailField')), 'test@example.com');
			await tester.enterText(find.byKey(Key('passwordField')), 'password123');
			await tester.tap(find.byType(ElevatedButton));

			verify(() => mockLoginCubit.login('test@example.com', 'password123')).called(1);
		});

		testWidgets('shows error message on login failure', (WidgetTester tester) async {
			whenListen(
				mockLoginCubit,
				Stream.fromIterable([LoginFailure('Invalid credentials')]),
				initialState: LoginInitial(),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<LoginCubit>(
							create: (_) => mockLoginCubit,
							child: LoginForm(),
						),
					),
				),
			);

			expect(find.text('Invalid credentials'), findsOneWidget);
		});
	});
}
