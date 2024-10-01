
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/cubits/login_cubit.dart';
import 'package:com.example.flutter_cubit_app/cubits/login_state.dart';

class LoginForm extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return BlocConsumer<LoginCubit, LoginState>(
			listener: (context, state) {
				if (state is LoginFailure) {
					ScaffoldMessenger.of(context).showSnackBar(
						SnackBar(content: Text(state.error)),
					);
				}
			},
			builder: (context, state) {
				return Padding(
					padding: const EdgeInsets.all(16.0),
					child: Form(
						child: Column(
							children: [
								TextFormField(
									key: Key('emailField'),
									decoration: InputDecoration(labelText: 'Email'),
								),
								TextFormField(
									key: Key('passwordField'),
									decoration: InputDecoration(labelText: 'Password'),
									obscureText: true,
								),
								SizedBox(height: 16),
								ElevatedButton(
									onPressed: () {
										final email = (context as FormState).fields['email']!.value as String;
										final password = (context as FormState).fields['password']!.value as String;
										context.read<LoginCubit>().login(email, password);
									},
									child: Text('Login'),
								),
							],
						),
					),
				);
			},
		);
	}
}
