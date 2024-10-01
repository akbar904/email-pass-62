
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:com.example.flutter_cubit_app/main.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}
class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

void main() {
	group('Main Widget Tests', () {
		testWidgets('should display LoginScreen initially', (tester) async {
			await tester.pumpWidget(MyApp());

			expect(find.byType(LoginScreen), findsOneWidget);
		});

		testWidgets('should display HomeScreen after successful login', (tester) async {
			final loginCubit = MockLoginCubit();
			final homeCubit = MockHomeCubit();

			whenListen(
				loginCubit,
				Stream.fromIterable([LoginInitial(), LoginSuccess()]),
				initialState: LoginInitial(),
			);

			await tester.pumpWidget(
				MultiBlocProvider(
					providers: [
						BlocProvider<LoginCubit>.value(value: loginCubit),
						BlocProvider<HomeCubit>.value(value: homeCubit),
					],
					child: MyApp(),
				),
			);

			await tester.pumpAndSettle();

			expect(find.byType(HomeScreen), findsOneWidget);
		});
	});

	group('Main Function Tests', () {
		test('main function initializes the app correctly', () {
			TestWidgetsFlutterBinding.ensureInitialized();

			main();

			expect(() => MyApp(), returnsNormally);
		});
	});
}
