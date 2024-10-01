
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.flutter_cubit_app/cubits/login_state.dart';

void main() {
	group('LoginState', () {
		test('initial state is correct', () {
			final state = LoginState();
			expect(state.status, LoginStatus.initial);
			expect(state.email, '');
			expect(state.password, '');
			expect(state.errorMessage, '');
		});

		test('copyWith updates state correctly', () {
			final initialState = LoginState();
			final newState = initialState.copyWith(
				status: LoginStatus.loading,
				email: 'test@example.com',
				password: 'password123',
				errorMessage: 'Error message',
			);

			expect(newState.status, LoginStatus.loading);
			expect(newState.email, 'test@example.com');
			expect(newState.password, 'password123');
			expect(newState.errorMessage, 'Error message');
		});

		test('props are correct', () {
			final state = LoginState();
			expect(state.props, [LoginStatus.initial, '', '', '']);
		});
	});
}
