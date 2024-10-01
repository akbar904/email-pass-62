
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.flutter_cubit_app/cubits/home_cubit.dart';

// Mock dependencies if any (none in this case since HomeCubit has no external dependencies)

// Define the main test suite for HomeCubit
void main() {
	group('HomeCubit', () {
		late HomeCubit homeCubit;

		setUp(() {
			homeCubit = HomeCubit();
		});

		tearDown(() {
			homeCubit.close();
		});

		blocTest<HomeCubit, HomeState>(
			'emits nothing when HomeCubit is instantiated',
			build: () => homeCubit,
			expect: () => [],
		);

		blocTest<HomeCubit, HomeState>(
			'emits HomeLoggedOutState when logout is called',
			build: () => homeCubit,
			act: (cubit) => cubit.logout(),
			expect: () => [isA<HomeLoggedOutState>()],
		);
	});
}
