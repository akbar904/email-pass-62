
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_cubit_app/cubits/login_cubit.dart';
import 'package:flutter_cubit_app/cubits/login_state.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
	group('LoginCubit', () {
		late MockLoginCubit loginCubit;

		setUp(() {
			loginCubit = MockLoginCubit();
		});

		test('initial state is LoginInitial', () {
			expect(loginCubit.state, equals(LoginInitial()));
		});

		blocTest<MockLoginCubit, LoginState>(
			'login emits [LoginLoading, LoginSuccess] when login is successful',
			build: () => loginCubit,
			act: (cubit) {
				when(() => cubit.login(any(), any())).thenAnswer((_) async {
					cubit.emit(LoginLoading());
					await Future<void>.delayed(const Duration(milliseconds: 1));
					cubit.emit(LoginSuccess());
				});
				cubit.login('test@example.com', 'password');
			},
			expect: () => [LoginLoading(), LoginSuccess()],
		);

		blocTest<MockLoginCubit, LoginState>(
			'login emits [LoginLoading, LoginFailure] when login fails',
			build: () => loginCubit,
			act: (cubit) {
				when(() => cubit.login(any(), any())).thenAnswer((_) async {
					cubit.emit(LoginLoading());
					await Future<void>.delayed(const Duration(milliseconds: 1));
					cubit.emit(LoginFailure('error'));
				});
				cubit.login('test@example.com', 'wrongpassword');
			},
			expect: () => [LoginLoading(), LoginFailure('error')],
		);
	});
}
