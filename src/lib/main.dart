
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/login_cubit.dart';
import 'cubits/home_cubit.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MultiBlocProvider(
			providers: [
				BlocProvider<LoginCubit>(
					create: (context) => LoginCubit(),
				),
				BlocProvider<HomeCubit>(
					create: (context) => HomeCubit(),
				),
			],
			child: MaterialApp(
				title: 'Flutter Cubit App',
				theme: ThemeData(
					primarySwatch: Colors.blue,
				),
				home: BlocBuilder<LoginCubit, LoginState>(
					builder: (context, state) {
						if (state is LoginSuccess) {
							return HomeScreen();
						} else {
							return LoginScreen();
						}
					},
				),
			),
		);
	}
}
