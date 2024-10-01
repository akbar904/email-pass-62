import 'package:bloc/bloc.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void login(String email, String password) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      // Simulate a network call
      await Future<void>.delayed(const Duration(milliseconds: 1));
      if (email == 'test@example.com' && password == 'password') {
        emit(state.copyWith(status: LoginStatus.success));
      } else {
        emit(state.copyWith(
            status: LoginStatus.failure,
            errorMessage: 'Invalid email or password'));
      }
    } catch (e) {
      emit(state.copyWith(
          status: LoginStatus.failure,
          errorMessage: 'An unexpected error occurred'));
    }
  }
}
