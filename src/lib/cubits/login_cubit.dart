
import 'package:bloc/bloc.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
	LoginCubit() : super(LoginInitial());

	void login(String email, String password) async {
		emit(LoginLoading());
		try {
			// Simulate a network call
			await Future<void>.delayed(const Duration(milliseconds: 1));
			if (email == 'test@example.com' && password == 'password') {
				emit(LoginSuccess());
			} else {
				emit(LoginFailure('Invalid email or password'));
			}
		} catch (e) {
			emit(LoginFailure('An unexpected error occurred'));
		}
	}
}
